//
//  PMOTableViewDataSource.h
//  Fyber-TestApp
//
//  Created by Peter Molnar on 01/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMOOfferStorageController.h"

@interface PMOTableViewDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithStorageController:(PMOOfferStorageController *)storage NS_DESIGNATED_INITIALIZER;


@end
