//
//  XUtilFunction.h
//  sinaweibo_ios_sdk_demo
//
//  Created by frank.xu on 11/15/12.
//  Copyright (c) 2012 SINA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XUtilFunction : NSObject 
+ (void)runOnMainQueueWithoutDeadlocking:(void (^)(void))block;
+ (void)report_memory:(NSString *)tag;
@end
