//
//  PMOOfferFactoryTests.m
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMOOfferStorageController.h"


@interface PMOOfferStorageControllerTests : XCTestCase
@property (strong, nonatomic) PMOOfferStorageController *storage;
@end

@implementation PMOOfferStorageControllerTests

- (void)setUp {
    [super setUp];
    
    PMOFyberOptions *options = [[PMOFyberOptions alloc] init];
    options.uid = @"spiderman";
    options.appid = @"2070";
    options.apiKey = @"1c915e3b5d42d05136185030892fbb846c278927";
    self.storage = [[PMOOfferStorageController alloc] initWithFyberOptions:options];
    
}

- (void)tearDown {
    self.storage = nil;
    [super tearDown];
}

- (void)testGeneration {
    
    // Only works with internet connection
    XCTestExpectation *expectation = [self keyValueObservingExpectationForObject:self.storage
                                                                         keyPath:@"offerCount"
                                                                         handler:^BOOL(id  _Nonnull observedObject, NSDictionary * _Nonnull change) {
                                                                             if ([self.storage offerCount] > 0 && [[self.storage offerControllerAtIndex:1] isKindOfClass:[PMOOfferController class]]) {
                                                                                 [expectation fulfill];
                                                                                 return true;
                                                                             } else {
                                                                                 return false;
                                                                             }
                                                                         }];
    [self.storage populateOfferStorage];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
}

@end
