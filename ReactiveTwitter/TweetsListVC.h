//
//  ViewController.h
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 01/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TwitterApiClient;

@interface TweetsListVC : UIViewController
@property (nonatomic, strong) TwitterApiClient *twitterApiClient;
@end

