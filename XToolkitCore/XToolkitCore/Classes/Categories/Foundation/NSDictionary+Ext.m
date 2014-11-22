//
//  NSDictionary+Ext.m
//  FAWAuto
//
//  Created by frank.xu on 11/4/12.
//  Copyright (c) 2012 YIN. All rights reserved.
//

#import "NSDictionary+Ext.h"

@implementation NSDictionary (Ext)

- (NSInteger)intForKey:(NSString *)key
{
    NSNumber *value = [self objectForKey:key];
    return [value integerValue];
}

- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    NSString *value = [self objectForKey:key];
    if (!value)
    {
        return defaultValue;
    }

    return [NSString stringWithFormat:@"%@", value];
}

- (NSString *)stringForKey:(NSString *)key
{
    return [self stringForKey:key defaultValue:@""];
}

- (NSDictionary *)dictionaryForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    
    return nil;
}

- (NSArray *)arrayForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    
    return nil;
}
@end
