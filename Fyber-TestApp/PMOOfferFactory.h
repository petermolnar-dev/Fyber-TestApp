//
//  PMOOfferFactory.h
//  Fyber-Test
//
//  Created by Peter Molnar on 29/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMOOffer.h"

@interface PMOOfferFactory : NSObject
+ (PMOOffer *)createOfferFromDisctionary:(NSDictionary *)dictionary;
@end
