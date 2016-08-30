//
//  PMOOfferFactory.h
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMOFyberOptions.h"
#import "PMOOffer.h"

@interface PMOOfferStorageController : NSObject

- (instancetype)initWithFyberOptions:(PMOFyberOptions *)fyberBasicOptions NS_DESIGNATED_INITIALIZER;
- (void)createOffers;

- (NSInteger)offerCount;
- (PMOOffer *)offerAtIndex:(NSInteger)index;

@end
