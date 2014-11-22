//
//  NSString+Ext.h
//  FAWAuto
//
//  Created by frank.xu on 11/4/12.
//  Copyright (c) 2012 YIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSString (Common_Ext)
- (NSString *)trimedString;
- (CGFloat)fullWidthCharaterLength;
- (NSString *)truncateWithLength:(CGFloat)len;
@end
