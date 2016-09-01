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

@property (strong, nonatomic) NSMutableString *ip;
@property (strong, nonatomic) NSMutableString *offer_type;
@property (unsafe_unretained, nonatomic, readonly) NSInteger offerCount;
- (instancetype)initWithFyberOptions:(PMOFyberOptions *)fyberBasicOptions NS_DESIGNATED_INITIALIZER;
- (void)populateOfferStorage;


- (PMOOffer *)offerAtIndex:(NSInteger)index;

@end
