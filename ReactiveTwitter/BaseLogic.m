//
//  BaseLogic.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "BaseLogic.h"

@interface BaseLogic ()
@property (nonatomic, assign) BOOL isDataLoaded;
@property (nonatomic, strong) RACCommand *loadDataCommand;
@property (nonatomic, strong) RACSubject *performedSegues;
@end

@implementation BaseLogic

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isDataLoaded = NO;
        self.loadDataCommand = [self createLoadDataCommand];
        self.performedSegues = [RACSubject subject];
    }
    return self;
}

- (RACSignal *)loadData {
    return [RACSignal empty];
}

- (void)startLogic {
    [self.loadDataCommand execute:self];
}

- (void)stopLogic {
}

#pragma mark - Private

- (RACCommand *)createLoadDataCommand {
    @weakify(self);
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [[self loadData]  doCompleted:^{
            @strongify(self);
            self.isDataLoaded = YES;
        }];
    }];
}

- (void)performSegueWithIdentifier:(NSString *)segue logic:(BaseLogic *)logic {
    [self.performedSegues sendNext:RACTuplePack(segue, logic)];
}

@end
