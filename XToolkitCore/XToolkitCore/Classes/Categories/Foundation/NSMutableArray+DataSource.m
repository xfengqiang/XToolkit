//
//  NSMutableArray+DataSource.m
//  XToolkitCore
//
//  Created by frank.xu on 11/22/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "NSMutableArray+DataSource.h"

@implementation NSMutableArray(PageDataSource)
@dynamic currentPageNumber;
@dynamic totalPageNumber;
@dynamic nextPageNumber;

DYN_SYNTHSIZE_FOR_INTEGER_X(pageNumber, PageNumber, -1);
DYN_SYNTHSIZE_FOR_INTEGER(totalPageNumber, TotalPageNumber);

- (NSInteger)nextPageNumber
{
    return self.currentPageNumber + 1;
}

- (BOOL)hasMoreData
{
    return self.currentPageNumber < self.totalPageNumber;
}

- (void)clearDataSource
{
    [self removeAllObjects];
    self.currentPageNumber = -1;
}
@end
