//
//  RequestUtil.h
//  FAWAuto
//
//  Created by frank.xu on 11/3/12.
//  Copyright (c) 2012 YIN. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAPIServerHost @"http://www.baidu.com"


@interface RequestUtil : NSObject

+ (NSString *)fullUrlByAppendPath:(NSString *)path;
+ (NSURL *)imageURLWithPath:(NSString *)path;
@end
