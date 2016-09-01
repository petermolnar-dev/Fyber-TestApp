//
//  PMOOfferFactory.m
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOOfferStorageController.h"
#import "PMOFyberAPIOptionsFactory.h"
#import "PMOServiceURLFactory.h"
#import "PMODataDownloader.h"
#import "PMOOfferFactory.h"
#import "PMOResponseSignatureValidator.h"

@interface PMOOfferStorageController()
@property (weak, nonatomic) PMOFyberOptions *fyberBasicOptions;
@property (strong, nonatomic) PMODataDownloader *downloader;
@property (strong, nonatomic) NSMutableDictionary *offers;
@end

@implementation PMOOfferStorageController

#pragma mark - Init
- (instancetype)initWithFyberOptions:(PMOFyberOptions *)fyberBasicOptions {
    self = [super init];
    if (self) {
        self.fyberBasicOptions = fyberBasicOptions;
        [self addDownloadObservers];
    }
    [self populateOfferStorage];
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not designated initializer"
                                   reason:@"Use +[[PMOOfferFactory alloc] initWithFyberOptions:]"
                                 userInfo:nil];
    return nil;
}


#pragma mark - Accessors
- (NSMutableDictionary *)offers {
    if (!_offers) {
        _offers = [[NSMutableDictionary alloc]init];
    }
    
    return _offers;
}
- (PMODataDownloader *)downloader {
    if (!_downloader) {
        _downloader = [[PMODataDownloader alloc] init];
    }
    return _downloader;
    
}

- (NSInteger)offerCount {
    return [self.offers count];
}


#pragma mark - Public interface

- (PMOOffer *)offerAtIndex:(NSInteger)index {
    NSArray *keys = [self.offers allKeys];
    
    return self.offers[keys[index]];
}


#pragma mark - filling up the storage
- (void)populateOfferStorage {
    // Build FyberAPIOPtions
    PMOFyberAPIOptionsFactory *optionsAPIFactory = [[PMOFyberAPIOptionsFactory alloc] initWithFyberBasicOptions:self.fyberBasicOptions];
    if (self.offer_type) {
        optionsAPIFactory.offerType = self.offer_type;
    }
    
    if (self.ip) {
        optionsAPIFactory.ipAddressAsString = self.ip;
    }
    NSDictionary *allOptions = [optionsAPIFactory allOptionsWithoutAPIKey];
    
    // Get ServiceURL
    PMOServiceURLFactory *urlFactory = [[PMOServiceURLFactory alloc] initWithFyberAPIOptions:allOptions apiKey:self.fyberBasicOptions.apiKey ];
    NSString *serviceURLString = [urlFactory createServiceURLString];
    
    // download offers
    [self.downloader downloadDataFromURL:[NSURL URLWithString:serviceURLString]];
    
}


#pragma mark - Handling notifications
- (void)addDownloadObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDownloadNotification:)
                                                 name:PMODataDownloaderDidDownloadEnded
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDownloadErrorNotification:) name:PMODataDownloaderError
                                               object:nil];
    
}

- (void)removeDownloadObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:PMODataDownloaderDidDownloadEnded
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:PMODataDownloaderError
                                                  object:nil];
    
}

- (void)didReceiveDownloadNotification:(NSNotification *) notification {
    [self removeDownloadObservers];
    
    NSData *data = notification.userInfo[@"data"];
    NSURLResponse *response = notification.userInfo[@"response"];
    
    if ([PMOResponseSignatureValidator validateDownloadedData:data response:response apiKey:self.fyberBasicOptions.apiKey]) {
        [self createOfferStorageFromData:data];
    }
}

-(void)didReceiveDownloadErrorNotification:(NSNotification *) notification {
    NSError *downloadError = [notification.userInfo objectForKey:@"error"];
    NSLog(@"Error while retrieveing the data: %@", [downloadError localizedDescription]);
    
}

- (void)createOfferStorageFromData:(NSData *)data {
    NSError *error;
    NSDictionary *JSONData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:&error];
    [self willChangeValueForKey:@"offerCount"];
    for (NSDictionary *currOffer in JSONData[@"offers"]) {
        PMOOffer *offer = [PMOOfferFactory createOfferFromDisctionary:currOffer];
        [self.offers setValue:offer forKey:offer.offer_id];
    }
    [self didChangeValueForKey:@"offerCount"];
    
    NSLog(@"Offers count:%lu", (unsigned long)[self.offers count]);
}

- (void)dealloc {
    [self removeDownloadObservers];
}
@end
