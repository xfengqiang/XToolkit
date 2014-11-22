//
//  FAWSettingsUtil.m
//  FAWAuto
//
//  Created by frank.xu on 11/3/12.
//  Copyright (c) 2012 YIN. All rights reserved.
//

#import "XSettingsUtil.h"

@implementation XSettingsUtil

+ (void)setBool:(BOOL)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)boolForKey:(NSString *)key 
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (void)setObject:(id)obj forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
}

+ (id)objectForKey:(NSString *)key defaultValue:(id)defaultValue
{
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (!value)
    {
        value = defaultValue;
    }
    return value;
}
@end
