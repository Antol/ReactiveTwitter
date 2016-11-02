//
//  StorageService.h
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface StorageService : NSObject
- (RACSignal *)saveTweets:(NSArray *)tweets;
- (RACSignal *)loadTweets;
@end
