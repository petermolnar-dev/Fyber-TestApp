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
#import "PMODataDownloadNotifications.h"
@interface PMOTableViewController ()

@property (strong, nonatomic)PMOOfferStorageController *storageController;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) PMOTableViewDataSource *dataSource;
@property (strong, nonatomic) PMOViewWithIndicator *indicatorView;

@end

@implementation PMOTableViewController
@dynamic view;

#pragma mark - Lifecycle
- (void)loadView {
    [super loadView];
    [self.view addSubview:self.indicatorView];
    [self setupStorage];
    [self setupDataSource];
    [self showSpinner];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"PMOOfferTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"OfferCell"];
    
    
}


- (PMOViewWithIndicator *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[PMOViewWithIndicator alloc] initWithFrame:self.view.frame];
    }
    return _indicatorView;
}

#pragma mark - Observers and triggers
- (void)setupObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDownloadErrorNotification:) name:PMODataDownloaderError
                                               object:nil];

    [self.storageController addObserver:self
                             forKeyPath:@"offerCount"
                                options:NSKeyValueObservingOptionNew
                                context:nil];

}


#pragma mark - Helpers
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self.storageController removeObserver:self
                                forKeyPath:@"offerCount"];
    
}

#pragma mark - Observers and Events
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqual:@"offerCount"]) {
        if (self.storageController.offerCount > 0) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self showTableView];
        }];
        } else {
            [self showMessage:@"No offers to be displayed"];
        }
        
    }
    
}

- (void)didReceiveDownloadErrorNotification:(NSNotification *)notification  {
    NSError *error = [notification.userInfo objectForKey:@"error"];
    [self showMessage:[error localizedDescription]];
}


#pragma mark - UI Helpers
- (void)showSpinner {
    self.tableView.hidden = true;
    [self.indicatorView startSpinner];
    
}

- (void)showMessage:(NSString *)message {
    self.tableView.hidden = true;
    [self.indicatorView stopSpinner];
    [self.indicatorView displayInitialMessage:message];
    
}

- (void)showTableView {
    self.tableView.hidden = false;
    [self.indicatorView removeFromSuperview];
    [self.tableView reloadData];
    
}

@end
