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
#import "StorageService.h"
#import "TweetPersistent.h"
#import "TweetLogic.h"

static NSString * const kTweetsListVCToTweetVC = @"toTweetVC";

@interface TweetsListLogic ()
@property (nonatomic, copy) NSArray *tweets;
@property (nonatomic, strong) RACCommand *selectTweetCommand;
@end

@implementation TweetsListLogic

- (void)startLogic {
    [super startLogic];
    @weakify(self);
    self.selectTweetCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *tweet) {
        @strongify(self);
        [self performSegueWithIdentifier:kTweetsListVCToTweetVC logic:[TweetLogic logicWithText:tweet]];
        return [RACSignal empty];
    }];
}

- (RACSignal *)loadData {
    @weakify(self);
    RACScheduler *scheduler = [RACScheduler scheduler];
    return [[[[[[[[[[[[[self.twitterApiClient
        login]
        deliverOn:scheduler]
        then:^RACSignal *{
            @strongify(self)
            return [self.twitterApiClient loadTimeline];
        }]
        flattenMap:^RACStream *(NSArray<TWTRTweet *> *x) {
            return [x.rac_sequence signalWithScheduler:scheduler];
        }]
        map:^id(TWTRTweet *tweet) {
            return [TweetPersistent tweetWithId:tweet.tweetID text:tweet.text];
        }]
        collect]
        flattenMap:^RACStream *(id x) {
            @strongify(self);
            return [self.storageService saveTweets:x];
        }]
        catch:^RACSignal *(NSError *error) {
            @strongify(self)
            return [self.storageService loadTweets];
        }]
        flattenMap:^RACStream *(NSArray<TweetPersistent *> *x) {
            return [x.rac_sequence signalWithScheduler:scheduler];
        }]
        map:^id(TweetPersistent *value) {
            return value.text;
        }]
        collect]
        deliverOn:[RACScheduler mainThreadScheduler]]
        doNext:^(id x) {
            @strongify(self)
            self.tweets = x;
        }];
}

@end
