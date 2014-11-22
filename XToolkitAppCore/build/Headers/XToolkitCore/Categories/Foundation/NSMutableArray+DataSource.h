//
//  NSMutableArray+DataSource.h
//  XToolkitCore
//
//  Created by frank.xu on 11/22/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XUtilDefine.h"

@interface NSMutableArray (PageDataSource)
@property (nonatomic, readonly) BOOL hasMoreData;
@property (nonatomic) NSInteger currentPageNumber;
@property (nonatomic) NSInteger nextPageNumber;
@property (nonatomic) NSInteger totalPageNumber;

- (void)clearDataSource;

@end
