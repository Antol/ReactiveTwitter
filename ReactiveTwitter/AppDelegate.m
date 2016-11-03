//
//  AppDelegate.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 01/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>

#import "TweetsListVC.h"
#import "TwitterApiClient.h"
#import "TweetsListLogic.h"
#import "StorageService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[[Twitter class]]];
    
    [self injection];
    return YES;
}

- (void)injection {
    UINavigationController *navigationVC = (id)self.window.rootViewController;
    NSAssert([navigationVC isKindOfClass:[UINavigationController class]], @"[navigationVC isKindOfClass:[UINavigationController class]]");
    TweetsListVC *rootVC = (id)navigationVC.viewControllers.firstObject;
    NSAssert([rootVC isKindOfClass:[TweetsListVC class]], @"[rootVC isKindOfClass:[TweetsListVC class]]");
    
    TweetsListLogic *rootLogic = [TweetsListLogic new];
    rootLogic.twitterApiClient = [TwitterApiClient new];
    rootLogic.storageService = [StorageService new];
    rootVC.logic = rootLogic;    
}

@end
