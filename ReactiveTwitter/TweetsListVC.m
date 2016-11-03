//
//  ViewController.m
//  ReactiveTwitter
//
//  Created by Anatoliy Peshkov on 01/11/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "TweetsListVC.h"
#import "ReactiveCocoa.h"
#import "TweetsListLogic.h"

static NSString * const kTweetCellReuseId = @"TweetCell";

@interface TweetsListVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) TweetsListLogic *logic;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *tweets;
@end

@implementation TweetsListVC
@dynamic logic;

- (void)setupUI {
    [super setupUI];
}

- (void)bindUIWithLogics {
    [super bindUIWithLogics];
    @weakify(self);
    
    RAC(self, tweets) = RACObserve(self.logic, tweets);
    
    [RACObserve(self, tweets) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTweetCellReuseId
                                                            forIndexPath:indexPath];
    cell.textLabel.text = self.tweets[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tweetText = self.tweets[indexPath.row];
    [self.logic.selectTweetCommand execute:tweetText];
}

@end



