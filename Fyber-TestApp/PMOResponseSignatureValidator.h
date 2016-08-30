//
//  PMOResponseSignatureValidator.h
//  Fyber-Test
//
//  Created by Peter Molnar on 30/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMOResponseSignatureValidator : NSObject
+ (BOOL)validateDownloadedData:(NSData *)data response:(NSURLResponse *)response apiKey:(NSString *)apiKey;
@end
