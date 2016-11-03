//
//  TweetLogic.h
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 03/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "BaseLogic.h"

@interface TweetLogic : BaseLogic
@property (nonatomic, copy, readonly) NSString *tweetText;
+ (instancetype)logicWithText:(NSString *)text;
@end
