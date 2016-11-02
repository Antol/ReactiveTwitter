//
//  UIView+PMNibManagement.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "UIView+PMNibManagement.h"

@implementation UIView (PMNibManagement)
+ (instancetype)viewFromNib {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    id view = [nib instantiateWithOwner:nil options:nil].firstObject;
    NSAssert([view isKindOfClass:[self class]], @"Failed to load view from nib: %@", [self class]);
    return view;
}
@end
