//
//  XUITabBar.h
//  TabViewControllerTest
//
//  Created by frank.xu on 11/27/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XUtilDefine.h"

@class XUITabBarItem;
@class XUITabBar;

@protocol  XUITabBarDelegate<NSObject>
- (void)tabar:(XUITabBar *)tabBar itemSelectedAtIndex:(NSInteger)index;
@end

@interface XUITabBar : UIView
@property (nonatomic, strong) UIImageView *indicatorView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, X_WEAK) id<XUITabBarDelegate> delegate;
@property (nonatomic) BOOL animatedTabSelect;

- (void)setItems:(NSArray *)items autoLayout:(BOOL)autoLayout;
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)aniamted;
- (XUITabBarItem *)barItemAtIndex:(NSInteger)index;
@end
