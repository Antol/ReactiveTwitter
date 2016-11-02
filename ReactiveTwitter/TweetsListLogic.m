//
//  TweetsListLogic.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "TweetsListLogic.h"
#import "TwitterApiClient.h"
#import <TwitterKit/TwitterKit.h>

@interface TweetsListLogic ()
@property (nonatomic, copy) NSArray *tweets;
@end

@implementation TweetsListLogic

- (RACSignal *)loadData {
    @weakify(self);
    return [[[[[[[self.twitterApiClient
        login]
        then:^RACSignal *{
            @strongify(self)
            return [self.twitterApiClient loadTimeline];
        }]
        flattenMap:^RACStream *(NSArray *x) {
            return x.rac_sequence.signal;
        }]
        map:^id(TWTRTweet *tweet) {
            return tweet.text;
        }]
        collect]
        deliverOn:[RACScheduler mainThreadScheduler]]
        doNext:^(id x) {
            @strongify(self)
            self.tweets = x;
        }];
}

@end
