//
//  PMOServiceURLFactory.m
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOServiceURLFactory.h"
#import "PMOHashGenerator.h"

@interface PMOServiceURLFactory()

@property (weak, nonatomic) NSDictionary *options;
@property (copy, nonatomic) NSString *apiKey;


@end

@implementation PMOServiceURLFactory


#pragma mark - Initializers
- (instancetype)initWithFyberAPIOptions:(NSDictionary *)options apiKey:(NSString *)apiKey {
    
    self= [super init];
    
    if (self) {
        self.options = options;
        self.apiKey = apiKey;
    }
    return self;
    
}

- (instancetype)initWithFyberAPIOptions:(NSDictionary *)options apiKey:(NSString *)apiKey resultType:(NSString *)resultType {
    
    if ([self initWithFyberAPIOptions:options apiKey:apiKey]) {
        self.resultType = resultType;
    }
    return self;
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not designated initializer"
                                   reason:@"Use +[[PMOServiceURLFactory alloc] initWithFyberAPIOptions:(NSDictionary *)options apiKey:(NSString *)apiKey]"
                                 userInfo:nil];
    return nil;
}


#pragma mark - Accessors
- (NSString *)resultType {
    
    if (!_resultType) {
        _resultType = @"offers.json";
    }
    
    return _resultType;
}


#pragma mark - Public API
- (NSString *)createServiceString {
    NSMutableString *stringForHashing =[[NSMutableString alloc] init];
    
    // Get the alphabetically ordered list of the keys
    NSArray *sortedKeys = [[self.options allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    // Traverse on them and built the string for hasing
    for (NSString *currKey in sortedKeys) {
        if ([currKey isEqual:[sortedKeys firstObject]]) {
            [stringForHashing appendFormat:@"%@=%@",currKey,self.options[currKey]];
        } else {
            [stringForHashing appendFormat:@"&%@=%@",currKey,self.options[currKey]];
            
        }
    }
    
    return stringForHashing;
    
}

- (NSString *)createServiceStringWithAPIKey {
    return [[self createServiceString] stringByAppendingFormat:@"&%@",self.apiKey];
    
}

- (NSString *)createServiceURLString {
    NSMutableString *serviceURLsString = [[NSMutableString alloc] init];
    NSString *serviceString = [self createServiceString];
    NSString *serviceStringWithAPIKey = [self createServiceStringWithAPIKey];

    [serviceURLsString appendFormat:@"http://api.fyber.com/feed/v1/%@?%@",self.resultType, serviceString];
    [serviceURLsString appendFormat:@"&hashkey=%@",[PMOHashGenerator generateSHA1FromString:serviceStringWithAPIKey]];
    
    return serviceURLsString;
    
}

@end
