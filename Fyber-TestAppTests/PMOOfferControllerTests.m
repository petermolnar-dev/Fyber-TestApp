//
//  PMOOfferControllerTests.m
//  Fyber-TestApp
//
//  Created by Peter Molnar on 05/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMOOfferController.h"

@interface PMOOfferControllerTests : XCTestCase
@property (strong, nonatomic) PMOOfferController *offerController;
@end

@implementation PMOOfferControllerTests

- (void)setUp {
    [super setUp];
    NSDictionary *offerData = @{@"offer_id" : @992979,
                                @"payout" : @15,
                                @"teaser" : @"Login, reach 231 points AND stay alive until the end of the chrono ",
                                @"thumbnail":@{
                                        @"hires": @"http://cdn4.sponsorpay.com/assets/59963/Screen_Shot_2015-11-26_at_13.45.08_original.png",
                                        @"lowres" : @"http://cdn4.sponsorpay.com/assets/59963/Screen_Shot_2015-11-26_at_13.45.08_original.png"
                                        },
                                @"title":@"Candy Catch",
                                @"link" : @"http://offer.fyber.com/mobile?impression=true&appid=2070&uid=spiderman&client=api&platform=android&appname=VC+Backend+Test&traffic_source=offer_api&country_code=MT&pubid=249&ip=92.251.23.109&apple_idfa=a39f268b5a2741dd96c9ca24bed5812a&ad_id=993565&os_version=9.3&ad_format=offer&group=Fyber&sig=a72e63d2ca267a28bba0c5400ca0a5a5cfb72368"};
    
    
    self.offerController = [[PMOOfferController alloc] initWithOfferDictionary:offerData];
}

- (void)tearDown {
    self.offerController = nil;
    [super tearDown];
}

- (void)testOfferControllerCreation {
    
    BOOL isCreatedWell = self.offerController && [self.offerController.offer_id intValue] == 992979;
    
    XCTAssertTrue(isCreatedWell);
}

@end
