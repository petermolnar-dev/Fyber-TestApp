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
@property (strong, nonatomic) NSMutableDictionary *offerControllers;
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
                                   reason:@"Use [[PMOOfferFactory alloc] initWithFyberOptions:]"
                                 userInfo:nil];
    return nil;
}


#pragma mark - Accessors
- (NSMutableDictionary *)offerControllers {
    if (!_offerControllers) {
        _offerControllers = [[NSMutableDictionary alloc]init];
    }
    
    return _offerControllers;
}
- (PMODataDownloader *)downloader {
    if (!_downloader) {
        _downloader = [[PMODataDownloader alloc] init];
    }
    return _downloader;
    
}

- (NSInteger)offerCount {
    return [self.offerControllers count];
}

#pragma mark - Public interface
- (PMOOfferController *)offerControllerAtIndex:(NSInteger)index {
    NSArray *keys = [self.offerControllers allKeys];
    
    return self.offerControllers[keys[index]];
}

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
}

- (void)removeDownloadObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:PMODataDownloaderDidDownloadEnded
                                                  object:nil];
    
}

#pragma mark - Notification receivers
- (void)didReceiveDownloadNotification:(NSNotification *) notification {
    [self removeDownloadObservers];
    
    NSData *data = notification.userInfo[@"data"];
    NSURLResponse *response = notification.userInfo[@"response"];
    
    [self willChangeValueForKey:@"offerCount"];

    if ([PMOResponseSignatureValidator validateDownloadedData:data response:response apiKey:self.fyberBasicOptions.apiKey]) {
        [self createOfferStorageFromData:data];
    }
    [self didChangeValueForKey:@"offerCount"];


}

#pragma mark - Helpers
- (void)createOfferStorageFromData:(NSData *)data {
    NSError *error;
    NSDictionary *JSONData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:&error];
    if (JSONData) {
    for (NSDictionary *currOffer in JSONData[@"offers"]) {
        PMOOfferController *offerController = [[PMOOfferController alloc] initWithOfferDictionary:currOffer];
       [self.offerControllers setValue:offerController forKey:offerController.offer_id];
    }
    } else {
        
    }
    
}

#pragma mark - Dealloc
- (void)dealloc {
    [self removeDownloadObservers];
}

@end
