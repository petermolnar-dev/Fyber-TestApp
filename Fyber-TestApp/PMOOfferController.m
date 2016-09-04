//
//  PMOOfferController.m
//  Fyber-TestApp
//
//  Created by Peter Molnar on 03/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOOfferController.h"
#import "PMOOfferFactory.h"

@interface PMOOfferController()
@property (strong, nonatomic) PMOOffer *offer;
@property (strong, nonatomic) UIImage *thumbnailImage;
@end

@implementation PMOOfferController

#pragma mark - Initializer
- (instancetype)initWithOfferDictionary:(NSDictionary *)offerDictionary {
    self = [super init];
    
    if (self && offerDictionary) {
        _offer = [PMOOfferFactory createOfferFromDisctionary:offerDictionary];
    }
    
    return self;
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not designated initializer"
                                   reason:@"Use [[PMOOfferController alloc] initWithOfferDictionary:]"
                                 userInfo:nil];
    return nil;
}

#pragma mark - Getters
- (NSString *)offer_id {
    return _offer.offer_id;
}

- (NSString *)title {
    return _offer.title;
}

- (NSString *)teaser {
    return _offer.teaser;
}

- (NSInteger)payout {
    return [_offer.payout integerValue];
}

- (UIImage *)thumbnail_hires {
    if (!_thumbnailImage) {
        [self downloadImage];
    }
    return _thumbnailImage;
}

#pragma mark - Helpers
- (void)downloadImage {
    // TODO: handle image download
    // url is from offer
}


@end
