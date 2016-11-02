//
//  BaseVC.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "BaseVC.h"
#import "BaseLogic.h"

@interface BaseVC ()
@property (nonatomic, weak) UIView *loadingView;
@end

@implementation BaseVC

- (void)dealloc {
    [self.logic stopLogic];
}

- (void)loadView {
    [self.logic startLogic];
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self bindUIWithLogics];
}

- (void)setupUI {
    
}

- (void)bindUIWithLogics {
    
}

@end
