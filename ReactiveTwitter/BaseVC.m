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
    [self.view addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)bindUIWithLogics {
    @weakify(self);
    
    RACSignal *shouldShowLoadingSignal = [RACObserve(self.logic, showLoadingView) distinctUntilChanged];
    RACSignal *executingSignal = [[[self.logic.loadDataCommand.executing skip:1] startWith:@YES] distinctUntilChanged];
    [[RACSignal
        combineLatest:@[executingSignal, shouldShowLoadingSignal]]
        subscribeNext:^(RACTuple *x) {
            @strongify(self);
            BOOL executing = [x.first boolValue];
            BOOL shouldShow = [x.second boolValue];
            
            if (shouldShow) {
                if (executing) {
                    self.loadingView.hidden = NO;
                }
                else {
                    [UIView animateWithDuration:0.3 animations:^{
                        self.loadingView.alpha = 0;
                    } completion:^(BOOL finished) {
                        self.loadingView.alpha = 1;
                        self.loadingView.hidden = YES;
                    }];
                }
            }
            else {
                self.loadingView.hidden = YES;
            }
        }];
    
    [self.logic.performedSegues subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self performSegueWithIdentifier:x.first sender:x.second];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(BaseLogic *)logic {
    if ([segue.destinationViewController isKindOfClass:[BaseVC class]] && logic) {
        BaseVC *destinationVC = segue.destinationViewController;
        destinationVC.logic = logic;
    }
}

@end
