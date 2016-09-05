//
//  PMOPictureDownloaderTests.m
//  Fyber-TestApp
//
//  Created by Peter Molnar on 05/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMOPictureDownloader.h"

@interface PMOPictureDownloaderTests : XCTestCase
@property (strong, nonatomic) PMOPictureDownloader *downloader;
@end

@implementation PMOPictureDownloaderTests

- (void)setUp {
    [super setUp];
    self.downloader = [[PMOPictureDownloader alloc] initWithPictureKey:@"1111"];
}

- (void)tearDown {
    self.downloader = nil;
    [super tearDown];
}

- (void)testDownloadImage {
// Needs internet connection

[self.downloader downloadDataFromURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/en/4/45/One_black_Pixel.png"]];
    
XCTestExpectation *expectation = [self expectationForNotification:PMOPictureDownloaderImageDidDownloaded
                                                           object:self.downloader
                                                          handler:^BOOL(NSNotification * _Nonnull notification) {
                                                              UIImage *testImage = [UIImage imageWithData:notification.userInfo[@"data"]];
                                                                                    
                                                              if (testImage && testImage.size.height ==1 && testImage.size.width==1) {
                                                                  [expectation fulfill];
                                                                  return true;
                                                                  
                                                              } else {
                                                                  return false;
                                                              }
                                                          }];

[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testDownloadFailure {
    [self.downloader downloadDataFromURL:[NSURL URLWithString:@"https://jfdklas.ko/wikipedia/en/4/45/One_black_Pixel.png"]];
    XCTestExpectation *expectation = [self expectationForNotification:PMOPictureDownloaderImageDownloadFailed
                                                               object:self.downloader
                                                              handler:^BOOL(NSNotification * _Nonnull notification) {
                                                                  NSError *error = [notification.userInfo objectForKey:@"error"];
                                                                  if (error && [error localizedDescription]) {
                                                                      [expectation fulfill];
                                                                      return true;
                                                                      
                                                                  } else {
                                                                      return false;
                                                                  }
                                                              }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}


@end
