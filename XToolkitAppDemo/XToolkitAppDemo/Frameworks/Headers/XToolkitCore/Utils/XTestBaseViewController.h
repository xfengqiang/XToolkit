//
//  XTestBaseViewController.h
//  XToolKitUIDemo
//
//  Created by frank.xu on 11/24/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestRowItem.h"

@interface XTestBaseViewController : UIViewController  <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong, readonly) NSMutableArray *dataSource;

- (void)addTestItem:(TestRowItem *)item;
- (void)handleTestItem:(TestRowItem *)item;
@end
