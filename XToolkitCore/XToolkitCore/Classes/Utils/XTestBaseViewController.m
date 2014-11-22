//
//  XTestBaseViewController.m
//  XToolKitUIDemo
//
//  Created by frank.xu on 11/24/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "XTestBaseViewController.h"


@interface XTestBaseViewController ()

@end

@implementation XTestBaseViewController

- (void)addTestItem:(TestRowItem *)item
{
    [self.dataSource addObject:item];
}

- (void)handleTestItem:(TestRowItem *)item
{
    if (item.type == ETestRowItemTypeMethod)
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-bridge-casts-disallowed-in-nonarc"
        [self performSelector:item.selector withObject:item.object];
#pragma clang diagnostic pop
    }
    else
    {
        Class class = NSClassFromString(item.controllerName);
        if (!class)
        {
            NSLog(@"Error:class %@ does not exsits", item.controllerName);
            return ;
        }
        
        UIViewController * ctrl = [[class alloc] initWithNibName:item.xibName bundle:nil];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
	// Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] ;
    }
    TestRowItem *item = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TestRowItem *item = [self.dataSource objectAtIndex:indexPath.row];
    [self handleTestItem:item];
}


@end
