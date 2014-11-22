//
//  UIImage+Ext.h
//  XToolkitCore
//
//  Created by frank.xu on 11/17/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Generate)
+ (UIImage*)imageWithColor:(UIColor*)colorOverlay size:(CGSize)size;
+ (UIImage*)imageWithColor:(UIColor*)colorOverlay size:(CGSize)size scale:(CGFloat)scale;
+ (UIImage *)imageWithColors:(NSArray *)colors size:(CGSize)size;
+ (UIImage *)imageWithColors:(NSArray *)colors size:(CGSize)size scale:(CGFloat)scale;

- (CGFloat)width;
- (CGFloat)height;
@end

@interface UIImage(Resize)
- (UIImage *)resizableImageWithCenterCapInsets;
- (UIImage *)tiledImage;
@end