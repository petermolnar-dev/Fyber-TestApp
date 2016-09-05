//
//  PMOFyberOptionsFactoryTests.m
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMOFyberAPIOptionsFactory.h"

@interface PMOFyberAPIOptionsFactoryTests : XCTestCase
@property (strong, nonatomic) PMOFyberAPIOptionsFactory *factory;
@end

@implementation PMOFyberAPIOptionsFactoryTests

- (void)setUp {
    [super setUp];
    PMOFyberOptions *options = [[PMOFyberOptions alloc] init];
    options.uid = @"spiderman";
    options.appid = @"2070";
    options.apiKey = @"1c915e3b5d42d05136185030892fbb846c278927";
    
    self.factory = [[PMOFyberAPIOptionsFactory alloc] initWithFyberBasicOptions:options];

}

- (void)tearDown {
    self.factory = nil;
    [super tearDown];
}

- (void)testOptions {
    NSDictionary *allOptions = [self.factory allOptionsWithoutAPIKey];
    
    XCTAssertNotNil(allOptions);
}

- (void)testMandatoryOptions{
    NSDictionary *allOptions = [self.factory allOptionsWithoutAPIKey];
    
    BOOL isCountOK = [allOptions count] == 7;
    BOOL isValueFilled = true;
    
    for (NSString *currKey in [allOptions allKeys]) {
        if (!allOptions[currKey]) {
            isValueFilled = false;
        }
    }
    
    XCTAssertTrue(isCountOK && isValueFilled);
}

- (void)testIP {
    self.factory.ipAddressAsString = @"109.235.143.113";
    NSDictionary *allOptions = [self.factory allOptionsWithoutAPIKey];
    
    BOOL isCountOK = [allOptions count] == 8;
    BOOL isValueFilled = true;
    
    for (NSString *currKey in [allOptions allKeys]) {
        if (!allOptions[currKey]) {
            isValueFilled = false;
        }
    }
    BOOL isIPFilled = [[allOptions objectForKey:@"ip"] isEqualToString:@"109.235.143.113"];
    
    
    XCTAssertTrue(isCountOK && isValueFilled && isIPFilled);
}

- (void)testOfferTypes {
    self.factory.offerType = @"112";
    NSDictionary *allOptions = [self.factory allOptionsWithoutAPIKey];
    
    BOOL isCountOK = [allOptions count] == 8;
    BOOL isValueFilled = true;
    
    for (NSString *currKey in [allOptions allKeys]) {
        if (!allOptions[currKey]) {
            isValueFilled = false;
        }
    }
    BOOL isOfferFilled = [[allOptions objectForKey:@"offer_types"] isEqualToString:@"112"];
    
    
    XCTAssertTrue(isCountOK && isValueFilled && isOfferFilled);
}



@end
