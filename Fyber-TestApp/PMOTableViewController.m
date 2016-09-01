//
//  PMOTableViewController.m
//  Fyber-TestApp
//
//  Created by Peter Molnar on 31/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOTableViewController.h"
#import "PMOOfferStorageController.h"
#import "PMOTableViewDataSource.h"

@interface PMOTableViewController ()

@property (strong, nonatomic)PMOOfferStorageController *storageController;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) PMOTableViewDataSource *dataSource;

@end

@implementation PMOTableViewController

@dynamic view;

- (void)loadView {
    [super loadView];
    [self setupStorage];
    [self setupDataSource];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"PMOOfferTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"OfferCell"];
    
//    self.tableView.hidden = true;
//    [self.view startSpinner];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - Observers and triggers
- (void)setupObservers {
    [self.storageController addObserver:self
                             forKeyPath:@"offerCount"
                                options:NSKeyValueObservingOptionNew
                                context:nil];

}

- (void)setupStorage {
    self.storageController = [[PMOOfferStorageController alloc] initWithFyberOptions:self.fyberBasicOptions ];
    self.storageController.ip = [NSMutableString stringWithString:@"109.235.143.113"];
    self.storageController.offer_type = [NSMutableString stringWithString:@"112"];
    [self setupObservers];
     [self.storageController populateOfferStorage ];

}

- (void)setupDataSource {
    self.dataSource = [[PMOTableViewDataSource alloc] initWithStorageController:self.storageController];
    self.tableView.dataSource = self.dataSource;
}

- (void)dealloc {
    [self.storageController removeObserver:self
                                forKeyPath:@"offerCount"];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqual:@"offerCount"]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
        
    }
    
}

@end
