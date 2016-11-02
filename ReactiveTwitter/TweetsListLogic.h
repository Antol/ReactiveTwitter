//
//  TweetsListLogic.h
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLogic.h"
@class TwitterApiClient;

@interface TweetsListLogic : BaseLogic
@property (nonatomic, strong) TwitterApiClient *twitterApiClient;

@property (nonatomic, copy, readonly) NSArray *tweets;
@end
