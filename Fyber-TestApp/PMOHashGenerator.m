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
    const char *cStr = [baseString UTF8String];
    unsigned char result[CC_SHA512_DIGEST_LENGTH];
    CC_SHA1(cStr, strlen(cStr), result);
    if (result) {
        /* SHA-1 hash has been calculated and stored in 'result'. */
        
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
        
        for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x", result[i]];
        return output;
        
    }
    return nil;
    
}

@end
