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

#pragma mark - Initializer
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupThumbnailImage];
    }
    
    return self;
}

#pragma mark - Lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupThumbnailImage];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.indicatorView startSpinner];
    [self setupThumbnailImage];
}

#pragma mark - Helpers
- (void)setupThumbnailImage {
    if (self.thumbnailImage) {
        self.thumbnailView.image = self.thumbnailImage;
        self.thumbnailView.hidden=false;
        
    } else {
        [self.indicatorView startSpinner];
    }
}

@end
