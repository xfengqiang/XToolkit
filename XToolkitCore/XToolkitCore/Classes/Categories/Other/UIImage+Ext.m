//
//  UIImage+Ext.m
//  XToolkitCore
//
//  Created by frank.xu on 11/17/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "UIImage+Ext.h"
#import "SSDrawingUtilities.h"

@implementation  UIImage(Generate)

+ (UIImage*)imageWithColor:(UIColor*)colorOverlay size:(CGSize)size
{
    return [UIImage imageWithColor:colorOverlay size:size scale:[UIScreen mainScreen].scale];
}

+ (UIImage*)imageWithColor:(UIColor*)colorOverlay size:(CGSize)size scale:(CGFloat)scale
{
    // create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    // determine bounding box of current image
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    // get drawing context
    CGContextRef context = UIGraphicsGetCurrentContext();
    // set overlay
    CGContextSetBlendMode(context, kCGBlendModeColor);
    CGContextSetFillColorWithColor(context, colorOverlay.CGColor);
    CGContextFillRect(context, rect);
    // save drawing-buffer
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    // end drawing context
    UIGraphicsEndImageContext();
    
    return returnImage;
}

+ (UIImage *)imageWithColors:(NSArray *)colors size:(CGSize)size
{
    return [UIImage imageWithColors:colors size:size scale:[UIScreen mainScreen].scale];
}

+ (UIImage *)imageWithColors:(NSArray *)colors size:(CGSize)size scale:(CGFloat)scale
{
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGGradientRef gradient = SSCreateGradientWithColors(colors);
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0,0), CGPointMake(0,size.height), 0);
    
    CFRelease(gradient);
    
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return returnImage;
}



- (CGFloat)width
{
    return self.size.width;
}

- (CGFloat)height
{
    return self.size.height;
}
@end

@implementation  UIImage(Resize)
- (UIImage *)resizableImageWithCenterCapInsets
{
    if ([self respondsToSelector:@selector(resizableImageWithCapInsets:)])
    {
          return [self resizableImageWithCapInsets:UIEdgeInsetsMake(self.size.height/2, self.size.width/2, self.size.height/2, self.size.width/2)];
    }
  return [self stretchableImageWithLeftCapWidth:self.width/2 topCapHeight:self.height/2];
}

- (UIImage *)tiledImage
{
    if ([self respondsToSelector:@selector(resizableImageWithCapInsets:)])
    {
        return [self resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    return [self stretchableImageWithLeftCapWidth:0 topCapHeight:0];
}
@end