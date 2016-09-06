//
//  PMOHashGenerator.m
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//
#import "PMOHashGenerator.h"
#import <CommonCrypto/CommonDigest.h>

@implementation PMOHashGenerator

+ (NSString *)generateSHA1FromString:(NSString *)baseString {
    NSData *data = [baseString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;

    
}
@end
