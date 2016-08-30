//
//  AppDelegate.m
//  Fyber-TestApp
//
//  Created by Peter Molnar on 30/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "AppDelegate.h"
#import "PMOOfferStorageController.h"

@interface AppDelegate ()
@property (strong, nonatomic) PMOOfferStorageController *storageController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    PMOFyberOptions *options = [[PMOFyberOptions alloc] init];
    options.uid = @"spiderman";
    options.appid = @"2070";
    options.apiKey = @"1c915e3b5d42d05136185030892fbb846c278927";
    
    self.storageController = [[PMOOfferStorageController alloc] initWithFyberOptions:options ];

    
    return YES;
}


@end
