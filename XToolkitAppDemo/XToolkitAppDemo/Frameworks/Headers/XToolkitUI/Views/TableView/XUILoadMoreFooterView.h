//
//  XUILoadMoreFooterView.h
//  XToolKitUIDemo
//
//  Created by frank.xu on 11/24/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDefaultActivityPadding 5
#define kLoadMoreViewHeight 44
#define kDefaultLoadMoreTriggerThrehold (kLoadMoreViewHeight/2) //XDragTriggerFooterView默认触发阀值

#define kDefaultTitleFont [UIFont boldSystemFontOfSize:14]

typedef enum {
    ELoadMoreFooterViewStateHidden = 1,
	ELoadMoreFooterViewStateVisible,
    ELoadMoreFooterViewStateTriggered,
    ELoadMoreFooterViewStateLoading
}LoadMoreFooterViewState;

@interface  XLoadMoreFooterViewBase : UIView
{
    LoadMoreFooterViewState _loadMoreState;
    __unsafe_unretained UIScrollView *_scrollView;
}
@property (nonatomic) LoadMoreFooterViewState loadMoreState;
@property (nonatomic, copy) void (^actionHandler)(void);
@property (nonatomic, unsafe_unretained) UIScrollView *scrollView;
- (id)initWithScrollView:(UIScrollView *)scrollView;
- (void)triggerLoadMore;
@end

/**
 * 露出时不触发loadMore的事件，上提一段距离之后触发
 */
@interface XDragTriggerFooterView : XLoadMoreFooterViewBase
@property (nonatomic) CGFloat triggerThrehold;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UILabel *loadingTitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@end


/**
 * XAppearTriggerFooterView footer露出时就触发loadMore的事件
 */
@interface XAppearTriggerFooterView : XDragTriggerFooterView
@end


/**
 * XTapTriggerFooterView footer通过按钮触发loadMore事件
 */
@interface XTapTriggerFooterView : XLoadMoreFooterViewBase
@property (nonatomic, strong) UIButton *loadMoreButton;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UILabel *loadingTitleLabel;
@end
