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

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[[Twitter class]]];
    
    [self injection];
    return YES;
}

- (void)injection {
    TweetsListVC *rootVC = (id)self.window.rootViewController;
    NSAssert([rootVC isKindOfClass:[TweetsListVC class]], @"[rootVC isKindOfClass:[TweetsListVC class]]");
    rootVC.twitterApiClient = [TwitterApiClient new];
}

@end
