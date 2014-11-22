//
//  NSString+Validate.h
//  XToolkit
//
//  Created by frank.xu on 11/13/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (X_Validate)
+ (BOOL)isValidName:(NSString *)str errorMsg:(NSString **)msg;
+ (BOOL)isValidPassword:(NSString *)str errorMsg:(NSString **)msg;
+ (BOOL)isValidPhoneNumber:(NSString *)str errorMsg:(NSString **)msg;
+ (BOOL)isValidYZM:(NSString *)str errorMsg:(NSString **)msg;
@end
