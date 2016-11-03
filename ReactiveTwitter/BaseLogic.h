//
//  BaseLogic.h
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface BaseLogic : NSObject
@property (nonatomic, strong, readonly) RACCommand *loadDataCommand;
@property (nonatomic, strong, readonly) RACSubject *performedSegues;

@property (nonatomic, assign, readonly) BOOL showLoadingView;

- (void)startLogic NS_REQUIRES_SUPER;
- (void)stopLogic NS_REQUIRES_SUPER;

- (RACSignal *)loadData;

- (void)performSegueWithIdentifier:(NSString *)segue logic:(BaseLogic *)logic;
@end
