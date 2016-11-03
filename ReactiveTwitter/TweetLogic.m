//
//  TweetLogic.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 03/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "TweetLogic.h"

@interface TweetLogic ()
@property (nonatomic, copy) NSString *tweetText;
@end

@implementation TweetLogic

+ (instancetype)logicWithText:(NSString *)text {
    TweetLogic *logic = [self new];
    logic.tweetText = text;
    return logic;
}

@end


