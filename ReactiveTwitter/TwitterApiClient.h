//
//  TweeterApiClient.h
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

@interface TwitterApiClient : NSObject
- (RACSignal *)login;
- (RACSignal *)loadTimeline;

- (RACSignal *)createTweet:(NSString *)tweet;
@end
