//
//  ViewController.m
//  Fyber-TestApp
//
//  Created by Peter Molnar on 30/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "ViewController.h"
#import "PMOFyberOptions.h"
#import "PMOTableViewController.h"

@interface ViewController ()

@property (strong, nonatomic) PMOFyberOptions *fyberBasicOptions;

@property (weak, nonatomic) IBOutlet UITextField *userid;
@property (weak, nonatomic) IBOutlet UITextField *apiKey;
@property (weak, nonatomic) IBOutlet UITextField *appID;

@end

@implementation ViewController



#pragma mark - Accessors
- (PMOFyberOptions *)fyberBasicOptions {
    if (!_fyberBasicOptions) {
        _fyberBasicOptions = [[PMOFyberOptions alloc] init];
    }
    
    return _fyberBasicOptions;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    self.fyberBasicOptions.uid = self.userid.text;
    self.fyberBasicOptions.appid = self.appID.text;
    self.fyberBasicOptions.apiKey = self.apiKey.text;

    if ([segue.identifier isEqualToString:@"displayOffers"]) {
        PMOTableViewController *destinationVC = (PMOTableViewController *)segue.destinationViewController;
        destinationVC.fyberBasicOptions = self.fyberBasicOptions;
    }
}


@end
