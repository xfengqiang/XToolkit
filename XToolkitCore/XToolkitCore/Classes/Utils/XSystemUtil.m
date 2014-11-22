//
//  XSystemUtil.m
//  XToolkitCore
//
//  Created by frank.xu on 11/27/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "XSystemUtil.h"

@implementation XSystemUtil
SINGLETON_FOR_CLASS_IMPLEMENTION(XSystemUtil)

+ (CGFloat)systemVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
@end
