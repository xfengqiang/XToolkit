//
//  NSMutableArray+Ext.m
//  FAWAuto
//
//  Created by frank.xu on 11/5/12.
//  Copyright (c) 2012 YIN. All rights reserved.
//

#import "NSMutableArray+Ext.h"
#import <objc/runtime.h>

@implementation NSMutableArray(Ext)

static char totalPageNumberKey;
static char currentPageNumberKey;

@dynamic currentPageNumber;
@dynamic totalPageNumber;
@dynamic nextPageNumber;

- (NSInteger)nextPageNumber
{
    return self.currentPageNumber + 1;
}

- (BOOL)hasMore
{
    return self.currentPageNumber < self.totalPageNumber;
}


- (int)currentPageNumber
{
    NSNumber *ret = (NSNumber *)objc_getAssociatedObject(self, &currentPageNumberKey);
    if (ret)
        return [ret intValue];
    else
        return -1; //Default Value.
}

- (void)setCurrentPageNumber:(int)pageNumber
{
    objc_setAssociatedObject(self, &currentPageNumberKey,
                             [NSNumber numberWithInt:pageNumber],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSInteger)totalPageNumber
{
    NSNumber *ret = (NSNumber *)objc_getAssociatedObject(self, &totalPageNumberKey);
    if (ret)
        return [ret integerValue];
    else
        return 0; //Default Value.
}

- (void)setTotalPageNumber:(NSInteger)pageNumber
{
    objc_setAssociatedObject(self, &totalPageNumberKey,
                             [NSNumber numberWithInt:(int)pageNumber],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)clearDataSource
{
    [self removeAllObjects];
    self.currentPageNumber = -1;
}
@end
