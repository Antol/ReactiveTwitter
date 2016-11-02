//
//  TweetPersistent.h
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import <Realm/Realm.h>

@interface TweetPersistent : RLMObject
@property (nonatomic, copy, readonly) NSString *idx;
@property (nonatomic, copy, readonly) NSString *text;

+ (instancetype)tweetWithId:(NSString *)idx text:(NSString *)text;

@end
