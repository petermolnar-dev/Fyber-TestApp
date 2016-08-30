//
//  PMOFyberOptionFactory.h
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMOFyberOptions.h"

@interface PMOFyberAPIOptionsFactory : NSObject

@property (copy, nonatomic) NSString *locale;
@property (copy, nonatomic) NSString *ipAddressAsString;
@property (copy, nonatomic) NSString *offerType;

- (instancetype)initWithFyberBasicOptions:(PMOFyberOptions *)basicOptions;
- (NSDictionary *)allOptionsWithoutAPIKey;
@end
