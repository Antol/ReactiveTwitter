//
//  TweeterApiClient.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "TwitterApiClient.h"
#import <TwitterKit/TwitterKit.h>

static NSString * const kTwitterApiClientBaseUrl = @"https://api.twitter.com/1.1/";

@interface TwitterApiClient ()
@property (nonatomic, strong) TWTRAPIClient *client;
@property (nonatomic, strong) NSMutableArray *fakeTweets;
@end

@implementation TwitterApiClient

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fakeTweets = [NSMutableArray array];
    }
    return self;
}

- (RACSignal *)login {
    if (self.client) {
        return [RACSignal empty];
    }
    
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
            @strongify(self);
            if (error) {
                [subscriber sendError:error];
            }
            else {
                self.client = [[TWTRAPIClient alloc] initWithUserID:session.userID];
                [subscriber sendCompleted];
            }
        }];
        return nil;
    }];
}

- (RACSignal *)loadTimeline {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSString *statusesShowEndpoint = [kTwitterApiClientBaseUrl stringByAppendingString:@"statuses/home_timeline.json"];
        NSError *clientError;
        NSURLRequest *request = [self.client URLRequestWithMethod:@"GET" URL:statusesShowEndpoint parameters:nil error:&clientError];
        if (!request) {
            [subscriber sendError:clientError];
            return nil;
        }
        
        [self.client
         sendTwitterRequest:request
         completion:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
             if (connectionError) {
                 [subscriber sendError:connectionError];
                 return;
             }
             
             NSError *jsonError;
             id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
             if (jsonError) {
                 [subscriber sendError:jsonError];
                 return;
             }
             
             json = [self.fakeTweets arrayByAddingObjectsFromArray:json];
             
             NSArray *tweets = [TWTRTweet tweetsWithJSONArray:json];
             [subscriber sendNext:tweets];
             [subscriber sendCompleted];
         }];
        return nil;
    }];
}

- (RACSignal *)createTweet:(NSString *)tweet {
    id fakeJsonTweet = @{
         @"text": tweet,
         @"id" : @793988224217653253,
         @"id_str" :@"793988224217653253",
         
         @"source" :@"<a href=\"http:\/\/www.google.com\/\" rel=\"nofollow\">Google<\/a>",
         @"truncated" : @NO,
         @"is_quote_status" : @NO,
         @"favorite_count" : @0,
         @"possibly_sensitive" : @NO,
         @"lang" :@"cs",
         @"entities" :@{
                 @"symbols" : @[
                         
                         ],
                 @"user_mentions" : @[
                         @{
                             @"id_str" :@"10228272",
                             @"id" : @10228272,
                             @"screen_name" :@"YouTube",
                             @"name" :@"YouTube",
                             @"indices" : @[
                                     @108,
                                     @116
                                     ]
                             }
                         ],
                 @"urls" : @[
                         @{
                             @"display_url" :@"youtu.be\/4eqVeToxa5A?a",
                             @"url" :@"https:\/\/t.co\/k0AhftyWhA",
                             @"indices" : @[
                                     @80,
                                     @103
                                     ],
                             @"expanded_url" :@"http:\/\/youtu.be\/4eqVeToxa5A?a"
                             }
                         ],
                 @"hashtags" : @[
                         
                         ]
                 },
         @"possibly_sensitive_appealable" : @NO,
         @"retweet_count" : @0,
         @"favorited" : @NO,
         @"user" :@{
                 @"protected" : @NO,
                 @"is_translator" : @NO,
                 @"profile_image_url" :@"http:\/\/pbs.twimg.com\/profile_images\/735763156039933953\/zBDXGJOS_normal.jpg",
                 @"created_at" :@"Sun Sep 27 15:33:48 +0000 2009",
                 @"id" : @77759974,
                 @"default_profile_image" : @NO,
                 @"listed_count" : @14,
                 @"profile_background_color" :@"3B94D9",
                 @"follow_request_sent" : @NO,
                 @"location" :@"Dublin City, Ireland",
                 @"entities" :@{
                         @"url" :@{
                                 @"urls" : @[
                                         @{
                                             @"display_url" :@"Instagram.com\/sk_wwheart",
                                             @"url" :@"https:\/\/t.co\/m3z0zPWSxc",
                                             @"indices" : @[
                                                     @0,
                                                     @23
                                                     ],
                                             @"expanded_url" :@"https:\/\/Instagram.com\/sk_wwheart"
                                             }
                                         ]
                                 },
                         @"description" :@{
                                 @"urls" : @[
                                         
                                         ]
                                 }
                         },
                 @"url" :@"https:\/\/t.co\/m3z0zPWSxc",
                 @"description" :@"хнытик мод он - this is my life, there are many like it but this one is mine",
                 @"followers_count" : @145,
                 @"geo_enabled" : @NO,
                 @"lang" :@"en",
                 @"profile_text_color" :@"333333",
                 @"statuses_count" : @9663,
                 @"following" : @YES,
                 @"notifications" : @NO,
                 @"profile_background_tile" : @YES,
                 @"profile_use_background_image" : @YES,
                 @"id_str" :@"77759974",
                 @"name" :@"Stanislava",
                 @"profile_image_url_https" :@"https:\/\/pbs.twimg.com\/profile_images\/735763156039933953\/zBDXGJOS_normal.jpg",
                 @"profile_sidebar_fill_color" :@"E6F6F9",
                 @"profile_sidebar_border_color" :@"FFFFFF",
                 @"contributors_enabled" : @NO,
                 @"default_profile" : @NO,
                 @"profile_banner_url" :@"https:\/\/pbs.twimg.com\/profile_banners\/77759974\/1464254582",
                 @"screen_name" :@"hbitik",
                 @"time_zone" :@"Moscow",
                 @"profile_background_image_url" :@"http:\/\/pbs.twimg.com\/profile_background_images\/622117436960079872\/j5L01V9o.jpg",
                 @"profile_background_image_url_https" :@"https:\/\/pbs.twimg.com\/profile_background_images\/622117436960079872\/j5L01V9o.jpg",
                 @"profile_link_color" :@"ABB8C2",
                 @"favourites_count" : @161,
                 @"is_translation_enabled" : @NO,
                 @"translator_type" :@"none",
                 @"utc_offset" : @10800,
                 @"friends_count" : @132,
                 @"verified" : @NO,
                 @"has_extended_profile" : @YES
                 },
         @"retweeted" : @NO,
         @"created_at" :@"Thu Nov 03 01:28:38 +0000 2016",
     };
    [self.fakeTweets insertObject:fakeJsonTweet atIndex:0];
    return [RACSignal empty];
}

@end


