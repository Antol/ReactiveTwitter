//
//  UITextField+RACChannelTerminal.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 03/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "UITextField+RACChannelTerminal.h"

@implementation UITextField (RACChannelTerminal)

- (void)establishChannelToTextWithTerminal:(RACChannelTerminal *)otherTerminal {
    RACChannelTerminal *terminal = self.rac_newTextChannel;
    [otherTerminal subscribe:terminal];
    [[terminal skip:1] subscribe:otherTerminal];
}


@end
