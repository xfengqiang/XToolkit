//
//  UIScreen+Size.m
//  XToolkitCore
//
//  Created by frank.xu on 6/16/13.
//  Copyright (c) 2013 Frank. All rights reserved.
//

#import "UIScreen+Size.h"

@implementation UIScreen (Size)
+ (CGFloat)width
{
    return [UIScreen mainScreen].bounds.size.width;
}
+ (CGFloat)height
{
    return [UIScreen mainScreen].bounds.size.height;
}
+ (CGRect)bounds
{
    return [UIScreen mainScreen].bounds;
}
@end
