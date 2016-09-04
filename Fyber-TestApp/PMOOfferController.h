//
//  PMOOfferController.h
//  Fyber-TestApp
//
//  Created by Peter Molnar on 03/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMOOffer.h"
@import UIKit;

@interface PMOOfferController : NSObject

@property (weak, nonatomic, readonly) NSString *offer_id;
@property (weak, nonatomic, readonly) NSString *title;
@property (weak, nonatomic, readonly) NSString *teaser;
@property (nonatomic, readonly) NSInteger payout;
@property (weak, nonatomic, readonly) UIImage *thumbnail_hires;

- (instancetype)initWithOfferDictionary:(NSDictionary *)offerDictionary NS_DESIGNATED_INITIALIZER;
@end
