//
//  XUITabBarItem.m
//  TabViewControllerTest
//
//  Created by frank.xu on 11/29/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "XUITabBarItem.h"

@implementation XUITabBarItem

- (void)onValueChanged:(BOOL)selected
{
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self onValueChanged:self.selected];
}

- (void)itemPressed
{
    self.selected = !self.selected;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
             [self addTarget:self action:@selector(itemPressed) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end
