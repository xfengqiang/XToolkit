//
//  NSString+Ext.m
//  FAWAuto
//
//  Created by frank.xu on 11/4/12.
//  Copyright (c) 2012 YIN. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString (Common_Ext)
- (NSString *)trimedString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (CGFloat)fullWidthCharaterLength
{
    float number = 0.0;
    for (int index = 0; index < [self length]; index++)
    {
        NSString *character = [self substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number++;
        }
        else
        {
            number = number + 0.5;
        }
    }
    return number;
    
}

- (NSString *)truncateWithLength:(CGFloat)len
{
    float number = 0.0;
    for (int index = 0; index < [self length]; index++)
    {
        NSString *character = [self substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number++;
        }
        else
        {
            number = number + 0.5;
        }
        
        if ( number > len)
        {
            return [self substringToIndex:index];
        }
        else if(number == len)
        {
            return [self substringToIndex:index+1];
        }
        
    }
    
    return self;
}


@end
