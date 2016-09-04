//
//  PMOOffer.h
//  Fyber-Test
//
//  Created by Peter Molnar on 29/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PMOOffer : NSObject

@property (copy, nonatomic) NSString *offer_id;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *teaser;
@property (copy, nonatomic) NSNumber *payout;
@property (strong, nonatomic) NSURL *imageURL;

@end
