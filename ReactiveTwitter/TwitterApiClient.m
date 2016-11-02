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
@end

@implementation TwitterApiClient

- (RACSignal *)login {
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
             
             NSArray *tweets = [TWTRTweet tweetsWithJSONArray:json];
             [subscriber sendNext:tweets];
             [subscriber sendCompleted];
         }];
        return nil;
    }];
}

@end


