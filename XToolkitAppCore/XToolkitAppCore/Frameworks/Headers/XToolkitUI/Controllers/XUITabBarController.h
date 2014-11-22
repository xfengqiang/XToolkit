//
//  XUITabBarController.h
//  TabViewControllerTest
//
//  Created by frank.xu on 11/29/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XUITabBar;
@interface XUITabBarController : UITabBarController
@property (nonatomic) CGFloat tabBarHeight;
@property (nonatomic, strong, readonly) IBOutlet XUITabBar *xTabBar;
- (void)loadTabBar:(XUITabBar *)tabBar;
@end
