//
//  FAWSettingsUtil.h
//  FAWAuto
//
//  Created by frank.xu on 11/3/12.
//  Copyright (c) 2012 YIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSettingsUtil : NSObject

+ (void)setBool:(BOOL)value forKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;

+ (void)setObject:(id)obj forKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key defaultValue:(id)defaultValue;

@end
