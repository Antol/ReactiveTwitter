//
//  ViewController.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 01/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "TweetsListVC.h"
#import "ReactiveCocoa.h"
#import "TwitterApiClient.h"

@interface TweetsListVC ()

@end

@implementation TweetsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData {
    @weakify(self);
    [[[self.twitterApiClient
        login]
        then:^RACSignal *{
            @strongify(self)
            return [self.twitterApiClient loadTimeline];
        }]
        subscribeNext:^(id x) {
            NSLog(@"================> %@", x);
        }];
}

@end
