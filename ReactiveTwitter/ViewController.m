//
//  ViewController.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 01/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "ViewController.h"
#import <TwitterKit/TwitterKit.h>
#import "ReactiveCocoa.h"

@interface ViewController ()
@property (nonatomic, strong) TWTRAPIClient *client;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
        @strongify(self);
        self.client = [[TWTRAPIClient alloc] initWithUserID:session.userID];
        NSString *statusesShowEndpoint = @"https://api.twitter.com/1.1/statuses/home_timeline.json";
        NSError *clientError;
        
        NSURLRequest *request = [self.client URLRequestWithMethod:@"GET" URL:statusesShowEndpoint parameters:nil error:&clientError];
        
        if (request) {
            [self.client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (data) {
                    NSError *jsonError;
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                    NSArray *tweets = [TWTRTweet tweetsWithJSONArray:json];
                    NSLog(@"================> %@", tweets);
                }
                else {
                    NSLog(@"Error: %@", connectionError);
                }
            }];
        }
        else {
            NSLog(@"Error: %@", clientError);
        }
    }];
}

@end
