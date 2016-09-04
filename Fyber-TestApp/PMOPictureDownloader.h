//
//  PMOPictureDownloader.h
//  Parallels-test
//
//  Created by Peter Molnar on 28/04/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

@import Foundation;
#import "PMODataDownloader.h"
#import "PMOPictureDownloaderNotifications.h"

@interface PMOPictureDownloader : PMODataDownloader

- (instancetype)initWithPictureKey:(NSString *)pictureKey NS_DESIGNATED_INITIALIZER;
@end
