//
//  TestRowItem.h
//  XTookKitUIDemo
//
//  Created by frank.xu on 11/18/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    ETestRowItemTypeMethod,
    ETestRowItemTypeController
}TestRowItemType;

@interface TestRowItem : NSObject
@property (nonatomic) TestRowItemType type;
@property (nonatomic, strong) NSString *controllerName;
@property (nonatomic, strong) NSString *xibName;
@property (nonatomic) SEL selector;
@property (nonatomic, strong) id object;
@property (nonatomic, strong) NSString *title;

+ (TestRowItem *)itemWithMethod:(SEL)selector title:(NSString *)title;
+ (TestRowItem *)itemWithController:(NSString *)controller title:(NSString *)title;
+ (TestRowItem *)itemWithController:(NSString *)controller nib:(NSString *)nib title:(NSString *)title;

@end
