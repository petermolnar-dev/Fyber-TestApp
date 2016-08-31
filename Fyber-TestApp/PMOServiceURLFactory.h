//
//  PMOServiceURLFactory.h
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMOServiceURLFactory : NSObject

@property (copy, nonatomic) NSString *resultType;

- (instancetype)initWithFyberAPIOptions:(NSDictionary *)options apiKey:(NSString *)apiKey NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithFyberAPIOptions:(NSDictionary *)options apiKey:(NSString *)apiKey resultType:(NSString *)resultType;

- (NSString *)createServiceString;
- (NSString *)createServiceURLString;
- (NSString *)createServiceStringWithAPIKey;

@end
