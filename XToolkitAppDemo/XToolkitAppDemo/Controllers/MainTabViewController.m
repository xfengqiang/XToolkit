//
//  MainTabViewController.m
//  XToolkitAppDemo
//
//  Created by frank.xu on 12/2/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "MainTabViewController.h"
#import "UIImage+Ext.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IconTitleTabBarItem *)tabItem:(NSString *)icon title:(NSString *)title
{
    UIImage *img = [UIImage imageNamed:icon];
    IconTitleTabBarItem *item = [[IconTitleTabBarItem alloc] initWithIcon:img
                                                          highlightedIcon:img
                                                                    title:title
                                                                    frame:CGRectZero];
    
    return item;
}


- (void)loadTabBar:(XUITabBar *)tabBar
{
    tabBar.animatedTabSelect = YES;
    tabBar.indicatorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 47, 60, 2)];
    tabBar.backgroundImage = [[UIImage imageNamed:@"tab_bg"] tiledImage];
    tabBar.indicatorView.backgroundColor = [UIColor grayColor];
    IconTitleTabBarItem *item0 = [self tabItem:@"first" title:@"Item 0"];
    IconTitleTabBarItem *item1 = [self tabItem:@"first" title:@"Item 1"];
    IconTitleTabBarItem *item2 = [self tabItem:@"first" title:@"Item 2"];
    tabBar.items = @[item0, item1, item2];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
