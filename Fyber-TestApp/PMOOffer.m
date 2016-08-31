//
//  PMOOffer.m
//  Fyber-Test
//
//  Created by Peter Molnar on 29/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOOffer.h"

@implementation PMOOffer

- (void)setThumbnail_hires:(UIImage *)thumbnail_hires {
    
    [self willChangeValueForKey:@"_thumbnail_hires"];
    _thumbnail_hires = thumbnail_hires;
    [self didChangeValueForKey:@"_thumbnail_hires"];
}
@end
