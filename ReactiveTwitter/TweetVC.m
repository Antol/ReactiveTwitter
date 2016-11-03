//
//  TweetVC.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 03/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "TweetVC.h"
#import "TweetLogic.h"

@interface TweetVC ()
@property (nonatomic, strong) TweetLogic *logic;
@property (nonatomic, weak) IBOutlet UILabel *tweetLabel;
@end

@implementation TweetVC
@dynamic logic;

- (void)bindUIWithLogics {
    [super bindUIWithLogics];
    RAC(self.tweetLabel, text) = RACObserve(self.logic, tweetText);
}

@end
