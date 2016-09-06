//
//  PMOTableViewDataSource.m
//  Fyber-TestApp
//
//  Created by Peter Molnar on 01/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOTableViewDataSource.h"


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
    
    if (!cell) {
        cell = [[PMOOfferTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:@"OfferCell"];
    }
    
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}


- (void)updateCell:(PMOOfferTableViewCell *)cell
       atIndexPath:(NSIndexPath *)indexPath {
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        PMOOfferController *offerController = [self.storageController offerControllerAtIndex:indexPath.row];
        if (offerController) {
            cell.offer_id = offerController.offer_id;
            cell.titleLabel.text = offerController.title;
            cell.descriptionLabel.text = offerController.teaser;
            cell.payoutLabel.textAlignment = NSTextAlignmentCenter;
            cell.payoutLabel.text = [NSString stringWithFormat:@"%ld",(long)offerController.payout];
            cell.thumbnailImage = offerController.thumbnail_hires;
            cell.indexPath = indexPath;
        }
//    }];
    
}


#pragma mark - Data Source protocol
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
