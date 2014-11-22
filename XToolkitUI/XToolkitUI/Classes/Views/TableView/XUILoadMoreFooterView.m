//
//  XUILoadMoreFooterView.m
//  XToolKitUIDemo
//
//  Created by frank.xu on 11/24/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "XUILoadMoreFooterView.h"


#pragma mark - Impemention for XLoadMoreFooterViewBase
@implementation XLoadMoreFooterViewBase
@synthesize loadMoreState = _loadMoreState;
@synthesize scrollView = _scrollView;

- (id)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super initWithFrame:CGRectMake(0, 0, scrollView.width, kLoadMoreViewHeight)])
    {
         self.scrollView = scrollView;
    }
    return self;
}

- (void)triggerLoadMore
{
    NSAssert(true, @"XLoadMoreFooterViewBase triggerLoadMore should be override");
}

- (void)dealloc
{
//     _scrollView = nil;  //最好不要在这里调用，有可能影响子类observer的移除
}
@end

@interface XDragTriggerFooterView()

@property (nonatomic, strong) UIView *loadingView;

@end

#pragma mark - Impemention for XDragTriggerFooterView
@implementation XDragTriggerFooterView
- (void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [_scrollView removeObserver:self forKeyPath:@"frame"];
    NSLog(@"===%s===msg:%@", __FUNCTION__, nil);
}

- (id)initWithScrollView:(UIScrollView *)scrollView
{
    self = [super initWithScrollView:scrollView];
    if (!self)
    {
        return nil;
    }
    
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.scrollView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
    _loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollView.width, 20)];
    _loadingView.backgroundColor = [UIColor clearColor];
    [self addSubview:_loadingView];
    [_loadingView centerInSuperView];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_loadingView addSubview:_activityIndicatorView];
    
    _loadingTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_activityIndicatorView.right, 0, 100, 20)];
    _loadingTitleLabel.text = NSLocalizedStringFromTable(@"drag_to_refresh_state_2", @"XToolKitUI", nil);
    _loadingTitleLabel.textColor = [UIColor darkGrayColor];
    _loadingTitleLabel.font = kDefaultTitleFont;
    _loadingTitleLabel.backgroundColor = [UIColor clearColor];
    [_loadingView addSubview:_loadingTitleLabel];
    [_loadingTitleLabel centerInSuperView];
    // default styling values
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 150, 20)];
    self.titleLabel.text = NSLocalizedStringFromTable(@"drag_to_refresh_state_0", @"XToolKitUI", nil);
    self.titleLabel.font = kDefaultTitleFont;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:self.titleLabel];
    [_titleLabel centerInSuperView];
    
    
    self.loadMoreState = ELoadMoreFooterViewStateVisible;
    
    self.triggerThrehold = kDefaultLoadMoreTriggerThrehold;
    return self;
}

- (void)layoutLoadingViews
{
    CGSize fontSize = [_titleLabel.text sizeWithFont:_titleLabel.font];
    _titleLabel.frame = CGRectMake(0, 0, fontSize.width, fontSize.height);
    [_titleLabel centerInSuperView];
    
    fontSize = [_loadingTitleLabel.text sizeWithFont:_loadingTitleLabel.font];
    _loadingTitleLabel.frame = CGRectMake(0, 0, fontSize.width, fontSize.height);
    [_loadingView centerTileSubViews:@[_activityIndicatorView, _loadingTitleLabel] padding:kDefaultActivityPadding];
}

- (UIColor *)titleColor
{
    return _titleLabel.textColor;
}

- (void)setTitleColor:(UIColor *)color
{
    _titleLabel.textColor = color;
    _loadingTitleLabel.textColor = color;
}

- (UIFont *)titleFont
{
    return _titleLabel.font;
}

- (void)setTitleFont:(UIFont *)font
{
    _titleLabel.font = font;
    _loadingTitleLabel.font = font;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutLoadingViews];
}

- (void)triggerLoadMore
{
    self.loadMoreState = ELoadMoreFooterViewStateLoading;
}

- (void)setLoadMoreState:(LoadMoreFooterViewState)newState {
    _loadMoreState = newState;
    NSLog(@"to ELoadMoreFooterViewStateTriggered");
    
    switch (newState) {
        case ELoadMoreFooterViewStateHidden:
            self.titleLabel.hidden = NO;
            self.titleLabel.text = NSLocalizedStringFromTable(@"drag_to_refresh_state_0", @"XToolKitUI", nil);
            [self.activityIndicatorView stopAnimating];
            break;
            
        case ELoadMoreFooterViewStateVisible:
            self.titleLabel.hidden = NO;
            self.titleLabel.text = NSLocalizedStringFromTable(@"drag_to_refresh_state_0", @"XToolKitUI", nil);
            [self.activityIndicatorView stopAnimating];
            break;
            
        case ELoadMoreFooterViewStateTriggered:
            self.titleLabel.hidden = NO;
            self.titleLabel.text =NSLocalizedStringFromTable(@"drag_to_refresh_state_1", @"XToolKitUI", nil);
            break;
            
        case ELoadMoreFooterViewStateLoading:
            self.titleLabel.hidden = YES;
            [self.activityIndicatorView startAnimating];
            if(self.actionHandler)
                self.actionHandler();
            break;
    }
    
    self.loadingView.hidden = !self.titleLabel.hidden;
}

- (BOOL)shouldBecomeTriggerSate:(CGFloat)threshold
{
    if (!self.scrollView.isDragging || !self.actionHandler)
    {
        return NO;
    }
    
    if (self.loadMoreState != ELoadMoreFooterViewStateVisible )
    {
        return NO;
    }
    return  threshold > self.triggerThrehold;
}

- (BOOL)shouldBecomeNormalState:(CGFloat)threhold
{
    if (self.loadMoreState == ELoadMoreFooterViewStateVisible)
    {
        return  NO;
    }
    
    return threhold < self.triggerThrehold ;
}

- (BOOL)shouldBecomeLoadingState:(CGFloat)threhold
{
    if (self.loadMoreState == ELoadMoreFooterViewStateLoading)
    {
        return NO;
    }
    
    if (self.scrollView.isDragging)
    {
        return NO;
    }
    
    if (self.loadMoreState != ELoadMoreFooterViewStateTriggered)
    {
        return NO;
    }
    return  YES;
}

- (void)scrollViewDidScroll:(CGPoint)contentOffset {
    CGFloat threshold = 0.f;
    NSLog(@"===%s===", __FUNCTION__);
    if (self.scrollView.contentSize.height < CGRectGetHeight(self.scrollView.frame))
    {
        UIPanGestureRecognizer *panGesture = nil;
        if ([self.scrollView respondsToSelector:@selector(panGestureRecognizer)])
        {
            panGesture = [self.scrollView panGestureRecognizer];
        }
        else
        {
            for (UIGestureRecognizer *g in self.scrollView.gestureRecognizers)
            {
                if ([g isKindOfClass:[UIPanGestureRecognizer class]])
                {
                    panGesture = (UIPanGestureRecognizer*)g;
                    break;
                }
            }
        }

        threshold = -[panGesture translationInView:self.scrollView].y;
    }
    else
    {
        threshold = self.scrollView.contentOffset.y+CGRectGetHeight(self.scrollView.frame)-self.scrollView.contentSize.height;
    }
    
//    NSLog(@"===scrollOffsetThreshold :%f", threshold);
    if ([self shouldBecomeTriggerSate:threshold])
    {
        self.loadMoreState = ELoadMoreFooterViewStateTriggered;
    }
    else if([self shouldBecomeNormalState:threshold])
    {
        self.loadMoreState = ELoadMoreFooterViewStateVisible;
    }
    else if([self shouldBecomeLoadingState:threshold])
    {
        self.loadMoreState = ELoadMoreFooterViewStateLoading;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"] && self.loadMoreState != ELoadMoreFooterViewStateLoading)
        [self scrollViewDidScroll:[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue]];
    else if([keyPath isEqualToString:@"frame"])
        [self layoutSubviews];
}
@end

#pragma mark - Implemention for XAppearTriggerFooterView
@implementation XAppearTriggerFooterView
- (id)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super initWithScrollView:scrollView])
    {
       
    }
    return self;
}

- (void)setLoadMoreState:(LoadMoreFooterViewState)loadMoreState
{
    _loadMoreState = loadMoreState;
    NSLog(@"to ELoadMoreFooterViewStateTriggered");
    
    switch (loadMoreState) {
        case ELoadMoreFooterViewStateVisible:
            self.titleLabel.hidden = NO;
            self.titleLabel.text = NSLocalizedStringFromTable(@"drag_to_refresh_state_0", @"XToolKitUI", nil);
            break;
        case ELoadMoreFooterViewStateTriggered:
            break;
        case ELoadMoreFooterViewStateLoading:
            self.titleLabel.hidden = YES;
            [self.activityIndicatorView startAnimating];
            if(self.actionHandler)
                self.actionHandler();
            break;
        default:
            break;
    }
    
    self.loadingView.hidden = !self.titleLabel.hidden;
}

- (void)triggerLoadMore
{
    self.loadMoreState = ELoadMoreFooterViewStateLoading;
}

- (BOOL)shouldBecomeTriggerSate:(CGFloat)threshold
{
    if (self.loadMoreState == ELoadMoreFooterViewStateTriggered)
    {
        return NO;
    }
    return self.scrollView.isDragging && threshold > self.triggerThrehold;
}

- (BOOL)shouldBecomeLoadingState:(CGFloat)threhold
{
    if (self.loadMoreState == ELoadMoreFooterViewStateLoading)
    {
        return NO;
    }
    
    return self.loadMoreState == ELoadMoreFooterViewStateTriggered;
}

- (BOOL)shouldBecomeNormalState:(CGFloat)threhold
{
    if (self.loadMoreState == ELoadMoreFooterViewStateVisible)
    {
        return  NO;
    }
    
    return threhold < self.triggerThrehold ;
}

- (void)scrollViewDidScroll:(CGPoint)contentOffset {
    CGFloat threshold = 0.f;
    
    if (self.scrollView.contentSize.height < CGRectGetHeight(self.scrollView.frame))
    {
        threshold = -[self.scrollView.panGestureRecognizer translationInView:self.scrollView].y;
    }
    else
    {
        threshold = self.scrollView.contentOffset.y+CGRectGetHeight(self.scrollView.frame)-self.scrollView.contentSize.height;
    }
    
//    NSLog(@"===scrollOffsetThreshold :%f", threshold);
    if ([self shouldBecomeNormalState:threshold])
    {
        self.loadMoreState = ELoadMoreFooterViewStateVisible;
        
    }else if ([self shouldBecomeTriggerSate:threshold])
    {
        self.loadMoreState = ELoadMoreFooterViewStateTriggered;
    }
    else if([self shouldBecomeLoadingState:threshold])
    {
        self.loadMoreState = ELoadMoreFooterViewStateLoading;
    }
}
@end

#pragma mark - Implemention for XTapTriggerFooterView
@implementation XTapTriggerFooterView
- (void)triggerLoadMore
{
    self.loadMoreState = ELoadMoreFooterViewStateLoading;
}

- (void)setLoadMoreState:(LoadMoreFooterViewState)loadMoreState
{
    _loadMoreState = loadMoreState;
    if (loadMoreState == ELoadMoreFooterViewStateLoading)
    {
        self.loadMoreButton.hidden = YES;
        if (self.actionHandler)
        {
            self.actionHandler();
        }
    }
    else
    {
        self.loadMoreButton.hidden = NO;
    }
    
    self.loadingTitleLabel.hidden = !self.loadMoreButton.hidden;
    self.activityIndicatorView.hidden = !self.loadMoreButton.hidden;
}

- (id)initWithScrollView:(UIScrollView *)scrollView
{
    if(self = [super initWithScrollView:scrollView])
    {
        _loadMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loadMoreButton.frame = CGRectMake(0, 0, 300, 40);
        [_loadMoreButton setTitle:NSLocalizedStringFromTable(@"top_to_load_more", @"XToolKitUI", nil) forState:UIControlStateNormal];
        _loadMoreButton.titleLabel.font = kDefaultTitleFont;
        [_loadMoreButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
         [_loadMoreButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [_loadMoreButton addTarget:self action:@selector(triggerLoadMore) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loadMoreButton];
        
        _loadingTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _loadingTitleLabel.textColor =[UIColor darkGrayColor];
        _loadingTitleLabel.font = kDefaultTitleFont;
        _loadingTitleLabel.text = NSLocalizedStringFromTable(@"drag_to_refresh_state_2", @"XToolKitUI", nil);
        [self addSubview:_loadingTitleLabel];
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_activityIndicatorView];
        self.loadMoreState = ELoadMoreFooterViewStateVisible;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_loadMoreButton centerInSuperView];
    [self centerTileSubViews:@[_activityIndicatorView, _loadingTitleLabel] padding:kDefaultActivityPadding];
}
@end
