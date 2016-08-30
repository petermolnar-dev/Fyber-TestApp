//
//  PMOHashGenerator.h
//  Fyber-Test
//
//  Created by Peter Molnar on 28/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PMOHashGenerator : NSObject

+ (NSString *)generateSHA1FromString:(NSString *)baseString;

@end
