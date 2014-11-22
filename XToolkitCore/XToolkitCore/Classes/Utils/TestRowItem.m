//
//  TestRowItem.m
//  XTookKitUIDemo
//
//  Created by frank.xu on 11/18/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "TestRowItem.h"

@implementation TestRowItem

+ (TestRowItem *)itemWithMethod:(SEL)selector title:(NSString *)title
{
    TestRowItem *item = [[TestRowItem alloc] init];
    item.type = ETestRowItemTypeMethod;
    item.selector = selector;
    item.title = title;
    return item;
}

+ (TestRowItem *)itemWithController:(NSString *)controller nib:(NSString *)nib title:(NSString *)title
{
    TestRowItem *item = [[TestRowItem alloc] init];
    item.type = ETestRowItemTypeController;
    item.controllerName = controller;
    item.title = title;
    item.xibName = nib;
    return item;
}

+ (TestRowItem *)itemWithController:(NSString *)controller title:(NSString *)title
{
    return [TestRowItem itemWithController:controller nib:nil title:title];
}
@end
