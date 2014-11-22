//
//  NSString+Validate.m
//  XToolkit
//
//  Created by frank.xu on 11/13/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "NSString+Validate.h"

@implementation NSString (X_Validate)

+ (BOOL)isValidName:(NSString *)str errorMsg:(NSString **)msg
{
    if (!str || [str trimedString].length == 0)
    {
        assginPtrValue(msg, @"用户名不能为空");
        return NO;
    }
    
    //TODO: add other check rules
    return YES;
}

+ (BOOL)isValidPassword:(NSString *)str errorMsg:(NSString **)msg
{
    if (str.length == 0)
    {
        assginPtrValue(msg, @"密码名不能为空");
        return NO;
    }
    
    //TODO: add other check rules
    return YES;
}

+ (BOOL)isValidPhoneNumber:(NSString *)str errorMsg:(NSString **)msg
{
    if (!str || [str trimedString].length == 0)
    {
        assginPtrValue(msg, @"电话号码名不能为空");
        return NO;
    }
    
    //TODO: add other check rules
    return YES;
}

+ (BOOL)isValidYZM:(NSString *)str errorMsg:(NSString **)msg
{
    if (!str || [str trimedString].length == 0)
    {
        assginPtrValue(msg, @"请输入短信验证码");
        return NO;
    }
    
    //TODO: add other check rules
    return YES;
}
@end
