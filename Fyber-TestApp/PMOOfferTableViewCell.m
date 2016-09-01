//
//  PMOPictureTableViewCell.m
//  Parallels-test
//
//  Created by Peter Molnar on 10/06/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOOfferTableViewCell.h"
#import "PMOViewWithIndicator.h"
#import "PMOOffer.h"

@implementation PMOOfferTableViewCell

#pragma mark - Helpers
- (void)setupThumbnailImage {
//    if (self.controller.thumbnailImage) {
//        self.thumbnailView.image = self.controller.thumbnailImage;
//        self.thumbnailView.hidden=false;
//        
//    } else {
//        [self.indicatorView startSpinner];
//    }
}

#pragma mark - Initialization and lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupThumbnailImage];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupThumbnailImage];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.indicatorView startSpinner];
    [self setupThumbnailImage];
}


#pragma mark - Observer triggers
//
//- (void)startObservingImage {
////    [self.offer addObserver:self
////            forKeyPath:@"thumbnail_hires"
////               options:NSKeyValueObservingOptionNew context:nil];
//}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"thumbnailImage"]) {
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
////            [self.indicatorView stopSpinner];
////            [self setupThumbnailImage];
//            [self setNeedsLayout];
//            
//        }];
//    }
//}
//
//- (void)dealloc {
////    [self.offer removeObserver:self
////                    forKeyPath:@"thumbnail_hires"];
//}

@end
