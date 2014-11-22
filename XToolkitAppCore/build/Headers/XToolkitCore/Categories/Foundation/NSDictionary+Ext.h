//
//  NSDictionary+Ext.h
//  FAWAuto
//
//  Created by frank.xu on 11/4/12.
//  Copyright (c) 2012 YIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Ext)
- (NSInteger)intForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSString *)stringForKey:(NSString *)key;
- (NSDictionary *)dictionaryForKey:(NSString *)key;
- (NSArray *)arrayForKey:(NSString *)key;
@end
