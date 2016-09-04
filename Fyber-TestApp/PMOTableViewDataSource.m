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

@property (weak, nonatomic) PMOOfferStorageController *storageController;

@end

@implementation PMOTableViewDataSource

#pragma mark - Initializers
- (instancetype)initWithStorageController:(PMOOfferStorageController *)storageContoller {
    self = [super init];
    
    if (self) {
        self.storageController = storageContoller;
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
    if (self.storageController.offerCount == 0) {
        return true;
    } else {
        return false;
    }
    
}


- (UITableViewCell *)customCellFortableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    PMOOfferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OfferCell" forIndexPath:indexPath];
    PMOOfferController *offerController = [self.storageController offerControllerAtIndex:indexPath.row];
    
    if (!cell) {
        cell = [[PMOOfferTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:@"OfferCell"];
    }
    
    if (offerController) {
        [self updateCell:cell atIndexPath:indexPath fromOfferController:offerController];
           }
    return cell;
}


- (void)updateCell:(PMOOfferTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath fromOfferController:(PMOOfferController *)offerController {
    cell.titleLabel.text = offerController.title;
    cell.descriptionLabel.text = offerController.teaser;
    cell.payoutLabel.textAlignment = NSTextAlignmentCenter;
    cell.payoutLabel.text = [NSString stringWithFormat:@"%d",offerController.payout];
    cell.thumbnailImage = offerController.thumbnail_hires;
    
}


#pragma mark - Data Source protocol
- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storageController.offerCount;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isStorageControllerEmpty]) {
        return nil;
    } else {
        return [self customCellFortableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
}



@end
