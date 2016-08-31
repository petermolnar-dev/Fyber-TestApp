//
//  PMOServiceURLFactoryTests.m
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMOServiceURLFactory.h"

@interface PMOServiceURLFactoryTests : XCTestCase
@property (strong, nonatomic) PMOServiceURLFactory *factory;
@end

@implementation PMOServiceURLFactoryTests

- (void)setUp {
    [super setUp];
    
    NSDictionary *testOptions = @{@"appid" : @157,
                                  @"uid" : @"player1",
                                  @"ip" : @"212.45.111.17",
                                  @"locale" : @"de",
                                  @"device_id" : @"2b6f0cc904d137be2e1730235f5664094b831186",
                                  @"ps_time" : @1312211903,
                                  @"pub0" : @"campaign2",
                                  @"page" : @2,
                                  @"timestamp" : @1312553361};
    NSString *apiKey = @"e95a21621a1865bcbae3bee89c4d4f84";
    self.factory = [[PMOServiceURLFactory alloc] initWithFyberAPIOptions:testOptions apiKey:apiKey];
    
}

- (void)tearDown {
    self.factory = nil;
    [super tearDown];
}

- (void)testServiceStringBuild {

    NSString *controlString = @"appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2&timestamp=1312553361&uid=player1";
    NSString *builtString = [self.factory createServiceString];

    XCTAssertTrue([builtString isEqualToString:controlString]);
}

- (void)testServiceStringWithAPIKeyBuild {
    NSString *controlString = @"appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2&timestamp=1312553361&uid=player1&e95a21621a1865bcbae3bee89c4d4f84";
    NSString *builtString = [self.factory createServiceStringWithAPIKey];
    
    XCTAssertTrue([builtString isEqualToString:controlString]);
}

- (void)testServiceURLBuild {
    
    NSString *controlString = @"http://api.fyber.com/feed/v1/offers.json?appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2&timestamp=1312553361&uid=player1&hashkey=7a2b1604c03d46eec1ecd4a686787b75dd693c4d";
    self.factory.resultType = @"offers.json";
    
    NSString *builtString =  [self.factory createServiceURLString];
    
    XCTAssertTrue([builtString isEqualToString:controlString]);
}

@end
