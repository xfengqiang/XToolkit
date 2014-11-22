//
//  XUITabBarItem.h
//  TabViewControllerTest
//
//  Created by frank.xu on 11/29/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XUITabBarItem : UIButton

@property (nonatomic) NSString *bageValue;

- (void)onValueChanged:(BOOL)selected;

@end
