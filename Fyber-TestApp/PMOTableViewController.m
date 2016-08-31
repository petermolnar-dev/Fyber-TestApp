//
//  PMOTableViewController.m
//  Fyber-TestApp
//
//  Created by Peter Molnar on 31/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOTableViewController.h"
#import "PMOOfferStorageController.h"

@interface PMOTableViewController ()

@property (strong, nonatomic)PMOOfferStorageController *storageController;
@end

@implementation PMOTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.storageController = [[PMOOfferStorageController alloc] initWithFyberOptions:self.fyberBasicOptions ];
    self.storageController.ip = [NSMutableString stringWithString:@"109.235.143.113"];
    self.storageController.offer_type = [NSMutableString stringWithString:@"112"];
    
    [self.storageController populateOfferStorage ];
    
}



@end
