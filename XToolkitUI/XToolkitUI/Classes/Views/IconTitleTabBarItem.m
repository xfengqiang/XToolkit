//
//  IconTitleTabBarItem.m
//  TabViewControllerTest
//
//  Created by frank.xu on 12/1/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "IconTitleTabBarItem.h"
#import "UIView+Positioning.h"

@implementation IconTitleTabBarItem

- (void)onValueChanged:(BOOL)selected
{
    self.iconView.highlighted = selected;
    self.xTitleLabel.highlighted = selected;
}

- (id)initWithIcon:(UIImage *)icon highlightedIcon:(UIImage *)highlightedIcon title:(NSString *)title frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _iconView = [[UIImageView alloc] initWithImage:icon];
        _iconView.highlightedImage = highlightedIcon;
        [self addSubview:_iconView];
        
        _xTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 15)];
        _xTitleLabel.font = [UIFont systemFontOfSize:14];
        _xTitleLabel.textColor = [UIColor whiteColor];
        _xTitleLabel.highlightedTextColor = [UIColor orangeColor];
        _xTitleLabel.backgroundColor = [UIColor clearColor];
        _xTitleLabel.text = title;
        [_xTitleLabel sizeToFit];
        [self addSubview:_xTitleLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_iconView centerHorizontallyInSuperView];
    [_xTitleLabel centerHorizontallyInSuperView];
    [self verticallyLayoutSubviews:@[_iconView, _xTitleLabel] padding:0 topPadding:0 bottomPadding:0];
    
}
@end
