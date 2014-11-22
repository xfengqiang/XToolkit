//
//  XUITableView.h
//  XToolKitUIDemo
//
//  Created by frank.xu on 11/22/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLoadMoreFooterViewBase;
@interface XUITableView : UITableView
@property (nonatomic, assign) XLoadMoreFooterViewBase *loadMoreFooterView;
@property (nonatomic) BOOL hasMoreData;
- (void)setLoadMoreBlock:(void(^)())loadMoreAction;
- (void)loadMoreDone:(BOOL)hasMoreData;
- (void)triggerLoadMore;
@end
