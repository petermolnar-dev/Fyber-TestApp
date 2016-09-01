//
//  PMOTableViewDataSource.m
//  Fyber-TestApp
//
//  Created by Peter Molnar on 01/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOTableViewDataSource.h"
#import "PMOOfferTableViewCell.h"

@interface PMOTableViewDataSource()

@property (weak, nonatomic) PMOOfferStorageController *storage;

@end

@implementation PMOTableViewDataSource

#pragma mark - Initializers
- (instancetype)initWithStorageController:(PMOOfferStorageController *)storage {
    self = [super init];
    
    if (self) {
        self.storage = storage;
    }
    
    return self;
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not designated initializer"
                                   reason:@"Use +[[PMOTableViewDataSource alloc] initWithStorageController:]"
                                 userInfo:nil];
    return nil;
}


#pragma mark - Helpers
- (BOOL)isStorageControllerEmpty {
    if (self.storage.offerCount == 0) {
        return true;
    } else {
        return false;
    }
    
}


- (UITableViewCell *)customCellFortableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    PMOOfferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OfferCell" forIndexPath:indexPath];
    PMOOffer *offer = [self.storage offerAtIndex:indexPath.row];
    
    if (!cell) {
        cell = [[PMOOfferTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:@"OfferCell"];
    }
    
    if (offer) {
        cell.offer = offer;
//        [cell startObservingImage];
        cell.titleLabel.text = offer.title;
        cell.descriptionLabel.text = offer.teaser;
        cell.payoutLabel.textAlignment = NSTextAlignmentCenter;
        cell.payoutLabel.text = [offer.payout stringValue];
        cell.thumbnailView.image = offer.thumbnail_hires;
    }
    return cell;
}


#pragma mark - Data Source protocol
- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"OfferCount : %lu", (long)self.storage.offerCount);
    return self.storage.offerCount;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isStorageControllerEmpty]) {
        return nil;
    } else {
        return [self customCellFortableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
}



@end
