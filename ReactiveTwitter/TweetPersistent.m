//
//  TweetPersistent.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "TweetPersistent.h"

@interface TweetPersistent ()
@property (nonatomic, copy) NSString *idx;
@property (nonatomic, copy) NSString *text;
@end

@implementation TweetPersistent

+ (instancetype)tweetWithId:(NSString *)idx text:(NSString *)text {
    TweetPersistent *tweet = [self new];
    tweet.idx = idx;
    tweet.text = text;
    return tweet;
}

@end
