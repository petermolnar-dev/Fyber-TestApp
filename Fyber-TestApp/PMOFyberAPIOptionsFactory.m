//
//  PMOFyberOptionFactory.m
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOFyberAPIOptionsFactory.h"
@import UIKit;
@import AdSupport;

@interface PMOFyberAPIOptionsFactory()
@property (strong, nonatomic) PMOFyberOptions *fyberBasicOptions;
@property (strong, nonatomic) NSMutableDictionary *allOptions;
@end

@implementation PMOFyberAPIOptionsFactory

- (instancetype)initWithFyberBasicOptions:(PMOFyberOptions *)basicOptions {
    self = [super init];
    
    if (self) {
        self.fyberBasicOptions = basicOptions;
        _allOptions = [[NSMutableDictionary alloc] init];
        self.allOptions = _allOptions;
    }
    
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not designated initializer"
                                   reason:@"Use +[[PMOFyberAPIOptionsFactory alloc] initWithFyberBasicOptions:]"
                                 userInfo:nil];
    return nil;
}

- (NSDictionary *)allOptionsWithoutAPIKey {
    [self addAppID];
    [self addUID];
    [self addLocaleOption];
    [self addOs_version];
    [self addApple_idfa];
    [self addApple_idfa_tracking_enabled];
    [self addIP];
    [self addOffer_types];
    [self addTimestamp];
    
    return self.allOptions;
    
}

- (void)addAppID {
    [self.allOptions setObject:self.fyberBasicOptions.appid forKey:@"appid"];
}

- (void)addUID {
    [self.allOptions setObject:self.fyberBasicOptions.uid forKey:@"uid"];
}

- (void)addLocaleOption {
    if (!self.locale) {
        [self.allOptions setObject:@"de" forKey:@"locale"];
    } else {
        [self.allOptions setObject:[self.locale lowercaseString] forKey:@"locale"];
        
    }
}

- (void)addOs_version {
    [self.allOptions setObject:[UIDevice currentDevice].systemVersion forKey:@"os_version"];
}

- (void)addApple_idfa {
    NSString *uuidString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [self.allOptions setObject:[uuidString lowercaseString] forKey:@"apple_idfa"];
}

- (void)addApple_idfa_tracking_enabled {
    if ([ASIdentifierManager sharedManager].advertisingTrackingEnabled) {
        [self.allOptions setObject:@"true" forKey:@"apple_idfa_tracking_enabled"];
    } else {
        [self.allOptions setObject:@"false" forKey:@"apple_idfa_tracking_enabled"];
        
    }
}

- (void)addIP {
    if (self.ipAddressAsString) {
        [self.allOptions setObject:self.ipAddressAsString forKey:@"ip"];
    }
}

- (void)addOffer_types {
    if (self.offerType) {
        [self.allOptions setObject:self.offerType forKey:@"offer_types"];
    }
}

- (void)addTimestamp {
    NSString * timeStampValue = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    [self.allOptions setObject:timeStampValue forKey:@"timestamp"];
    
}


@end
