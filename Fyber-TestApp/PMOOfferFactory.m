//
//  PMOOfferFactory.m
//  Fyber-Test
//
//  Created by Peter Molnar on 29/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOOfferFactory.h"

@implementation PMOOfferFactory
+ (PMOOffer *)createOfferFromDisctionary:(NSDictionary*)dictionary {
    PMOOffer *currentOffer = [[PMOOffer alloc] init];
    currentOffer.offer_id = dictionary[@"offer_id"];
    currentOffer.title = dictionary[@"title"];
    currentOffer.teaser = dictionary[@"teaser"];
    currentOffer.payout = dictionary[@"payout"];
    currentOffer.imageURL = [NSURL URLWithString:dictionary[@"thumbnail"][@"hires"]];
    
    return currentOffer;
}

@end
