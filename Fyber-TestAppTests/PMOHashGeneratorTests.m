//
//  PMOHashGeneratorTests.m
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMOHashGenerator.h"

@interface PMOHashGeneratorTests : XCTestCase
@end

@implementation PMOHashGeneratorTests

- (void)testHasGenerated {
    
    NSString *controlString = @"appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2&timestamp=1312553361&uid=player1&e95a21621a1865bcbae3bee89c4d4f84";
    NSString *testHash = @"7a2b1604c03d46eec1ecd4a686787b75dd693c4d";
    NSString *theGeneratedHash = [PMOHashGenerator generateSHA1FromString:controlString];
    
    
    XCTAssertTrue([theGeneratedHash isEqualToString:testHash]);
}

@end
