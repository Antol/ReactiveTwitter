//
//  BaseVC.h
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"
@class BaseLogic;

@interface BaseVC : UIViewController
@property (strong, nonatomic) BaseLogic *logic;

- (void)setupUI NS_REQUIRES_SUPER;
- (void)bindUIWithLogics NS_REQUIRES_SUPER;
@end
