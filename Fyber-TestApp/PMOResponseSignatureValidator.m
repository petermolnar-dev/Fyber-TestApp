//
//  PMOResponseSignatureValidator.m
//  Fyber-Test
//
//  Created by Peter Molnar on 30/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOResponseSignatureValidator.h"
#import "PMOHashGenerator.h"

@implementation PMOResponseSignatureValidator
+ (BOOL)validateDownloadedData:(NSData *)data response:(NSURLResponse *)response apiKey:(NSString *)apiKey {
    NSString *dataAsString =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *headers = [(NSHTTPURLResponse *)response allHeaderFields];
    
    NSString *responseHash = headers[@"X-Sponsorpay-Response-Signature"];
    
    NSString *stringForHashing = [dataAsString stringByAppendingString:apiKey];
    NSString *calculatedHash = [PMOHashGenerator generateSHA1FromString:stringForHashing];
    
    if (![responseHash isEqualToString:calculatedHash]) {
        NSLog(@"Response hash validation failed, response: %@, calculated: &@", responseHash, calculatedHash);
    }
    
    return [responseHash isEqualToString:calculatedHash];
    
}

@end
