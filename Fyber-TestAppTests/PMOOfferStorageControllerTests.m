//
//  PMOOfferFactoryTests.m
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMOOfferStorageController.h"
#import "PMOOffer.h"

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

//- (void)testGenration {
//    
//    // Only works with internet connection
//    
//    [self.storage populateOfferStorage];
//    NSInteger offerCount =[self.storage offerCount];
//    BOOL isThereAnyOffer = [self.storage offerCount] > 0;
//    BOOL isFirstElementAnOffer = [[self.storage offerAtIndex:@0] isKindOfClass:[PMOOffer class]];
//    
//    XCTAssertTrue(isThereAnyOffer && isFirstElementAnOffer);
//    
//}

@end
