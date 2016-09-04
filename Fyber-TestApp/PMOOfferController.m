//
//  PMOOfferController.m
//  Fyber-TestApp
//
//  Created by Peter Molnar on 03/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOOfferController.h"
#import "PMOOfferFactory.h"
#import "PMOPictureDownloader.h"
#import "PMOPictureReadyForUseNotification.h"

@interface PMOOfferController()
@property (strong, nonatomic) PMOOffer *offer;
@property (strong, nonatomic) UIImage *thumbnailImage;
@property (strong, nonatomic) PMOPictureDownloader *pictureDownloader;
@end

@implementation PMOOfferController

#pragma mark - Initializer
- (instancetype)initWithOfferDictionary:(NSDictionary *)offerDictionary {
    self = [super init];
    
    if (self && offerDictionary) {
        _offer = [PMOOfferFactory createOfferFromDisctionary:offerDictionary];
    }
    
    return self;
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not designated initializer"
                                   reason:@"Use [[PMOOfferController alloc] initWithOfferDictionary:]"
                                 userInfo:nil];
    return nil;
}

#pragma mark - Getters
- (NSString *)offer_id {
    return _offer.offer_id;
}

- (NSString *)title {
    return _offer.title;
}

- (NSString *)teaser {
    return _offer.teaser;
}

- (NSInteger)payout {
    return [_offer.payout integerValue];
}

- (UIImage *)thumbnail_hires {
    if (!_thumbnailImage) {
        [self downloadImage];
    }
    return _thumbnailImage;
}

- (PMOPictureDownloader *)pictureDownloader {
    if (!_pictureDownloader) {
        _pictureDownloader = [[PMOPictureDownloader alloc] initWithPictureKey:self.offer_id];
    }
    return _pictureDownloader;
}

#pragma mark - Helpers

- (BOOL)isNotificationForThePicture:(NSNotification *)notification {
    NSString *notificationForPictureWithKey = [notification.userInfo valueForKey:@"pictureKey"];
    return [notificationForPictureWithKey isEqualToString:self.offer_id];
}

- (void)downloadImage {
    [self registerDownloadObservers];
    [self.pictureDownloader downloadDataFromURL:self.offer.imageURL];
    
}

- (void)didPictureDownloaded:(NSNotification *)notification {
    if ([self isNotificationForThePicture:notification])  {
        [self removeDownloadObservers];
        NSData *downloadedData = [notification.userInfo objectForKey:@"data"];
        UIImage *image =[UIImage imageWithData:downloadedData];
        self.thumbnailImage = image;
        NSDictionary *userInfo = @{@"offer_id": self.offer_id};
        [[NSNotificationCenter defaultCenter] postNotificationName:PMOPictureReadyToUse
                                                            object:nil
                                                          userInfo:userInfo];
    }
    
}

- (void)didPictureDownloadFailed:(NSNotification *)notification {
    
    if ([self isNotificationForThePicture:notification])  {
        [self removeDownloadObservers];
        NSError *error = [notification.userInfo objectForKey:@"error"];
        NSLog(@"Image downlad failed: %@",[error localizedDescription]);
    }
}

- (void)registerDownloadObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didPictureDownloaded:)
                                                 name:PMOPictureDownloaderImageDidDownloaded
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didPictureDownloadFailed:)
                                                 name:PMOPictureDownloaderImageDownloadFailed
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

#pragma mark - Dealloc
- (void)dealloc {
    [self removeDownloadObservers];
}

@end
