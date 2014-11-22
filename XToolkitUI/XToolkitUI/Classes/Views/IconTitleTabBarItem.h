//
//  IconTitleTabBarItem.h
//  TabViewControllerTest
//
//  Created by frank.xu on 12/1/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "XUITabBarItem.h"

@interface IconTitleTabBarItem : XUITabBarItem

@property (nonatomic, strong, readonly) UIImageView *iconView;
@property (nonatomic, strong, readonly) UILabel *xTitleLabel;

- (id)initWithIcon:(UIImage *)icon highlightedIcon:(UIImage *)highlightedIcon title:(NSString *)title frame:(CGRect)frame;
@end
