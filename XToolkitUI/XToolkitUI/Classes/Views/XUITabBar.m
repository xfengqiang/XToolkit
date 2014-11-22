//
//  XUITabBar.m
//  TabViewControllerTest
//
//  Created by frank.xu on 11/27/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "XUITabBar.h"
#import "XUITabBarItem.h"

@interface XUITabBar() <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic) CGFloat tabWidth;

- (void)adjustIndicatorViewPosition;
- (CGPoint)centerForTabIndex:(NSInteger)index;
@end

@implementation XUITabBar

- (void)initCustomViews
{
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backgroundImageView.userInteractionEnabled = YES;
    [self addSubview:_backgroundImageView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
    tapGesture.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapGesture];
}

- (void)adjustIndicatorViewPosition
{
    CGPoint center = [self centerForTabIndex:self.selectedIndex];
    _indicatorView.center = CGPointMake(center.x, _indicatorView.center.y);
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImageView.image = backgroundImage;
}

- (void)setIndicatorView:(UIImageView *)indicatorView
{
    if (_indicatorView != indicatorView)
    {
        [_indicatorView removeFromSuperview];
        _indicatorView = indicatorView;
        [self insertSubview:_indicatorView atIndex:1];
        [self adjustIndicatorViewPosition];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initCustomViews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _selectedIndex = -1;
        [self initCustomViews];
    }
    return self;
}

- (void)setItems:(NSArray *)items autoLayout:(BOOL)autoLayout
{
    if (items.count == 0)
    {
        return ;
    }
    
    for (UIView *v in _items)
    {
        [v removeFromSuperview];
    }
    _items = items;
    _tabWidth = CGRectGetWidth(self.frame)/items.count;
    CGFloat marginLeft = 0.f;
    CGFloat height = CGRectGetHeight(self.frame);
    for (UIView *v in items)
    {
        [self addSubview:v];
        CGFloat width = autoLayout?_tabWidth:CGRectGetWidth(v.frame);
        v.frame = CGRectMake(marginLeft, 0, width, height);
        marginLeft += width;
    }
  
    [self setSelectedIndex:0 ];
    [self adjustIndicatorViewPosition];
}

- (void)setItems:(NSArray *)items
{
    [self setItems:items autoLayout:YES];
}

- (CGPoint)centerForTabIndex:(NSInteger)index
{
    return CGPointMake(_tabWidth*(index+0.5), CGRectGetMinY(self.frame));
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    [self setSelectedIndex:selectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)aniamted
{
    if (_selectedIndex == selectedIndex)
    {
        return ;
    }
    
    _selectedIndex = selectedIndex;
    for (XUITabBarItem *item in self.items)
    {
        item.selected = NO;
    }
    XUITabBarItem *selectedItem = [self.items objectAtIndex:selectedIndex];
    selectedItem.selected = YES;

    CGPoint centerForTabIndex = [self centerForTabIndex:selectedIndex];
    CGFloat duration = aniamted ? 0.25 : 0;
    [UIView animateWithDuration:duration animations:^{
        _indicatorView.center = CGPointMake(centerForTabIndex.x, _indicatorView.center.y);
    } completion:^(BOOL finished) {
        if (_delegate && [_delegate respondsToSelector:@selector(tabar:itemSelectedAtIndex:)]) {
            [_delegate tabar:self itemSelectedAtIndex:_selectedIndex];
        }
    }];
}

- (XUITabBarItem *)barItemAtIndex:(NSInteger)index
{
    return [self.items objectAtIndex:index];
}

- (void)onTapGesture:(UITapGestureRecognizer *)tapGesture
{
    if(tapGesture.state == UIGestureRecognizerStateRecognized)
    {
        CGPoint location = [tapGesture locationInView:self];        
        [self setSelectedIndex:location.x / _tabWidth animated:_animatedTabSelect];
    }
}

@end
