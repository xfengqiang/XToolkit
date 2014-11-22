//
//  XUITableView.m
//  XToolKitUIDemo
//
//  Created by frank.xu on 11/22/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "XUITableView.h"
#import "UIView+Positioning.h"
#import "XUILoadMoreFooterView.h"

#pragma mark - Impemention for XUITableView
@interface XUITableView ()

@end


@implementation XUITableView
@synthesize loadMoreFooterView = _loadMoreFooterView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (XLoadMoreFooterViewBase *)loadMoreFooterView
{
    if (! self.tableFooterView)
    {
        XDragTriggerFooterView *footerView = [[XDragTriggerFooterView alloc] initWithScrollView:self];
        _loadMoreFooterView = footerView;
        self.tableFooterView = _loadMoreFooterView;
    }
    return _loadMoreFooterView;
}

- (void)setLoadMoreFooterView:(XLoadMoreFooterViewBase *)loadMoreFooterView
{
//    _loadMoreFooterView = loadMoreFooterView;
    self.tableFooterView = loadMoreFooterView;
}

- (void)setLoadMoreBlock:(void(^)())loadMoreAction
{
    self.loadMoreFooterView.actionHandler = loadMoreAction;
}

- (void)setHasMoreData:(BOOL)hasMoreData
{
    if (hasMoreData)
    {
        if (self.tableFooterView != self.loadMoreFooterView) {
            self.tableFooterView = self.loadMoreFooterView;
        }
    }
    else
    {
        self.tableFooterView = nil;
    }
}

- (void)triggerLoadMore
{
    [self.loadMoreFooterView triggerLoadMore];
}

- (void)loadMoreDone:(BOOL)hasMoreData
{
    self.hasMoreData = hasMoreData;
    self.loadMoreFooterView.loadMoreState = ELoadMoreFooterViewStateVisible;
}

- (void)dealloc
{
    NSLog(@"===%s===", __FUNCTION__);
}

@end
