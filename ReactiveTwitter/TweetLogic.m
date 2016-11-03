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
@property (nonatomic, assign) BOOL showLoadingView;
@end

@implementation TweetLogic
@dynamic showLoadingView;

+ (instancetype)logicWithText:(NSString *)text {
    TweetLogic *logic = [self new];
    logic.tweetText = text;
    return logic;
}

- (void)startLogic {
    [super startLogic];
    self.showLoadingView = NO;
}

@end


