//
//  BaseVC.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "BaseVC.h"
#import "BaseLogic.h"
#import "LoadingView.h"
#import "UIView+PMNibManagement.h"
#import "Masonry.h"

@interface BaseVC ()
@property (nonatomic, strong) UIView *loadingView;
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
    self.loadingView = [LoadingView viewFromNib];
}

- (void)bindUIWithLogics {
    @weakify(self);
    [[self.logic.loadDataCommand.executing skip:1] subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [self.view addSubview:self.loadingView];
            [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
            }];
        }
        else {
            [UIView animateWithDuration:0.3 animations:^{
                self.loadingView.alpha = 0;
            } completion:^(BOOL finished) {
                self.loadingView.alpha = 1;
                [self.loadingView removeFromSuperview];
            }];
        }
    }];
}

@end
