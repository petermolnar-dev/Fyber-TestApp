//
//  PMOPictureDownloader.m
//  Parallels-test
//
//  Created by Peter Molnar on 28/04/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOPictureDownloader.h"


@interface PMOPictureDownloader()
@property (copy, nonatomic) NSString *pictureKey;
@end

@implementation PMOPictureDownloader

- (instancetype)initWithPictureKey:(NSString *)pictureKey {
    self = [super init];
    
    if (self) {
        _pictureKey = pictureKey;
    }
    
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not designated initializer"
                                   reason:@"Use [[PMOPictureDownloader alloc] initWithPictureKey:]"
                                 userInfo:nil];
    return nil;
}

- (void)notifyObserverWithProcessedData:(NSDictionary *)data {
    NSDictionary *userInfo = @{@"data" : data[@"data"],
                               @"response" : data[@"response"],
                               @"pictureKey" : self.pictureKey};
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PMOPictureDownloaderImageDidDownloaded
                                                        object:self
                                                      userInfo:userInfo];
    
}

- (NSDictionary *)userInforForErrorNotification:(NSError *)error {
    NSDictionary *userInfo;
    if (self.pictureKey) {
        userInfo = @{@"error" : error,
                     @"pictureKey": self.pictureKey};
    } else {
        userInfo = @{@"error" : error};
    }
    
    return userInfo;
}


- (void)notifyObserverWithError:(NSError *)error {
    NSDictionary *userInfo = [self userInforForErrorNotification:error];
    [[NSNotificationCenter defaultCenter] postNotificationName:PMOPictureDownloaderImageDownloadFailed
                                                        object:self
                                                      userInfo:userInfo];
}
@end
