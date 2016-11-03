//
//  StorageService.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 02/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "StorageService.h"
#import <Realm/Realm.h>
#import "TweetPersistent.h"

@implementation StorageService

- (RACSignal *)saveTweets:(NSArray *)tweets {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSError *realmError;
        RLMRealm *realm = [RLMRealm defaultRealm];
        BOOL sucsess = [realm transactionWithBlock:^{
            [realm addOrUpdateObjectsFromArray:tweets];
        } error:&realmError];
        
        if (sucsess) {
            [subscriber sendNext:tweets];
            [subscriber sendCompleted];
        }
        else {
            [subscriber sendError:realmError];
        }
        
        return [RACDisposable disposableWithBlock:^{
            if (realm.inWriteTransaction) {
                [realm cancelWriteTransaction];
            }
        }];;
    }];
}

- (RACSignal *)loadTweets {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        RLMResults *result = [TweetPersistent allObjects];
        NSMutableArray *tweets = [NSMutableArray array];
        for (id obj in result) {
            [tweets addObject:obj];
        }
        [subscriber sendNext:tweets];
        [subscriber sendCompleted];
        return nil;
    }];
}

@end
