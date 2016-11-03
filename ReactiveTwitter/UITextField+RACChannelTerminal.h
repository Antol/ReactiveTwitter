//
//  UITextField+RACChannelTerminal.h
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 03/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

@interface UITextField (RACChannelTerminal)
- (void)establishChannelToTextWithTerminal:(RACChannelTerminal *)otherTerminal;
@end
