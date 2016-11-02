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
@property (nonatomic, assign, readonly) BOOL isDataLoaded;
@property (nonatomic, strong, readonly) RACCommand *loadDataCommand;

- (void)startLogic NS_REQUIRES_SUPER;
- (void)stopLogic NS_REQUIRES_SUPER;

- (RACSignal *)loadData;
@end
