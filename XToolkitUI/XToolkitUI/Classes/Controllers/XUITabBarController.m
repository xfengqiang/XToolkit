//
//  XUITabBarController.m
//  TabViewControllerTest
//
//  Created by frank.xu on 11/29/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "XUITabBarController.h"
#import "XUITabBar.h"
#import "IconTitleTabBarItem.h"
#import "UIImage+Ext.h"

@interface XUITabBarController ()  <XUITabBarDelegate>

@end

@implementation XUITabBarController
- (CGFloat)tabBarHeight
{
    return CGRectGetHeight(self.tabBar.frame);
}

- (void)setTabBarHeight:(CGFloat)tabBarHeight
{
    UIView *transitionView = nil;
    for (UIView *v in self.view.subviews)
    {
        if ([NSStringFromClass([v class]) isEqualToString:@"UITransitionView"])
        {
            transitionView = v;
            break;
        }
    }
    
    CGRect frame = transitionView.frame;
    frame.size.height = CGRectGetHeight(self.view.frame)-tabBarHeight;
    transitionView.frame = frame;
    
    frame = self.tabBar.frame;
    frame.size.height = tabBarHeight;
    frame.origin.y = CGRectGetHeight(self.view.frame)-tabBarHeight;
    self.tabBar.frame = frame;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarHeight = 49;
    }
    return self;
}

- (XUITabBarItem *)tabBarItem:(NSString *)title icon:(UIImage *)icon frame:(CGRect)frame
{
    UIImage *img = icon;
    IconTitleTabBarItem *item1 = [[IconTitleTabBarItem alloc] initWithIcon:img highlightedIcon:[UIImage imageWithColor:[UIColor orangeColor] size:icon.size ]
                                                               title:title frame:frame];
    item1.showsTouchWhenHighlighted = YES;
//    item1.iconView.backgroundColor = [UIColor yellowColor];
//    item1.xTitleLabel.backgroundColor = [UIColor greenColor];
    return item1;
}

- (void)loadTabBar:(XUITabBar *)tabBar
{
    tabBar.backgroundColor = [UIColor blackColor];
    tabBar.animatedTabSelect = YES;
    tabBar.backgroundImage = [[UIImage imageWithColors:
                               @[[UIColor colorWithRed:0 green:0 blue:0 alpha:1],
                               [UIColor colorWithRed:0.6 green:0 blue:0 alpha:0.6],
                               [UIColor colorWithRed:0.8 green:0 blue:0 alpha:0.8]
                               ]
                                                  size:CGSizeMake(320, 49)] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    tabBar.indicatorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    tabBar.indicatorView.backgroundColor = [UIColor redColor];
    
    CGFloat width = 320 / 3;
    CGRect frame = CGRectMake(0, 0, width, 49);
    UIImage *normalImage = [UIImage imageWithColor:[UIColor grayColor] size:CGSizeMake(30, 30)] ;
    XUITabBarItem *item1 = [self tabBarItem:@"First" icon:normalImage frame:frame];
    XUITabBarItem *item2 = [self tabBarItem:@"Second" icon:normalImage frame:frame];
    [tabBar setItems:@[item1, item2]];
}

- (void)loadView
{
    [super loadView];
    _xTabBar = [[XUITabBar alloc] initWithFrame:self.tabBar.bounds];
    _xTabBar.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _xTabBar.delegate = self;
    [self.tabBar addSubview:_xTabBar];
    [self loadTabBar:_xTabBar];
    [self setTabBarHeight:50];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBar bringSubviewToFront:self.xTabBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    [self.xTabBar setSelectedIndex:selectedIndex];
}

#pragma mark - XUITabBarDelegate
- (void)tabar:(XUITabBar *)tabBar itemSelectedAtIndex:(NSInteger)index
{
    [super setSelectedIndex:index];
}
@end
