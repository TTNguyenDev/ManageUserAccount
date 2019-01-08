//
//  DisplayAllFriends.m
//  Mioto_objc
//
//  Created by TT Nguyen on 1/7/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

#import "DisplayAllFriends.h"

@interface DisplayAllFriends () <FireBaseListener> {
    IBOutlet UITableView *tableView;
    AccountBusiness *shareInstance;
    NSMutableArray *users;
}

@end

@implementation DisplayAllFriends

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Friends";
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerNib:[UINib nibWithNibName:@"DisplayAllUsersCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
    shareInstance = [AccountBusiness sharedInstance];
    shareInstance.listener = self;
    users = [NSMutableArray array];
    [shareInstance fetchAllData];
}

- (void)successProfileWith:(Profile *)profile{
    if (profile) {
        [users addObject:profile];
        [[users objectAtIndex:0] mUserName];
    }
    tableView.reloadData;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DisplayAllUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    }
    [cell didSetFromUser:[users objectAtIndex:indexPath.row]];
    return cell;
}
@end
