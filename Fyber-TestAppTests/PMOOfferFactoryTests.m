//
//  PMOOfferFactoryTests.m
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMOOfferStorageController.h"

@interface PMOOfferFactoryTests : XCTestCase
@property (strong, nonatomic) PMOOfferStorageController *factory;
@end

@implementation PMOOfferFactoryTests

- (void)setUp {
    [super setUp];
    self.factory = [[PMOOfferFactory alloc] init];
    
    PMOFyberOptions *options = [[PMOFyberOptions alloc] init];
    options.uid = @"spiderman";
    options.appid = @"2070";
    options.apiKey = @"1c915e3b5d42d05136185030892fbb846c278927";
    
    self.factory.FyberOptions = options;
}

- (void)tearDown {
    self.factory = nil;
    [super tearDown];
}

- (void)testGenration {
    
    [self.factory createOffers];
}

@end
