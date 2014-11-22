//
//  NSMutableArray+Ext.h
//  FAWAuto
//
//  Created by frank.xu on 11/5/12.
//  Copyright (c) 2012 YIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray(Ext)
@property (nonatomic, readonly) BOOL hasMore;
@property (nonatomic) NSInteger currentPageNumber;
@property (nonatomic) NSInteger nextPageNumber;
@property (nonatomic) NSInteger totalPageNumber;

- (void)clearDataSource;
@end
