//
//  XUtilFunction.m
//  sinaweibo_ios_sdk_demo
//
//  Created by frank.xu on 11/15/12.
//  Copyright (c) 2012 SINA. All rights reserved.
//

#import "XUtilFunction.h"
#import <mach/mach.h>

@implementation XUtilFunction
+ (void) runOnMainQueueWithoutDeadlocking:(void (^)(void))block
{
	if ([NSThread isMainThread])
	{
		block();
	}
	else
	{
		dispatch_sync(dispatch_get_main_queue(), block);
	}
}

+ (void) report_memory:(NSString *)tag
{
    if (!tag)
        tag = @"Default";
    
    struct task_basic_info info;
    
    mach_msg_type_number_t size = sizeof(info);
    
    kern_return_t kerr = task_info(mach_task_self(),
                                   
                                   TASK_BASIC_INFO,
                                   
                                   (task_info_t)&info,
                                   
                                   &size);
    if( kerr == KERN_SUCCESS ) {
        NSLog(@"%@ - Memory used: %lud", tag, info.resident_size); //in bytes
    } else {
        NSLog(@"%@ - Error: %s", tag, mach_error_string(kerr));
    }
}
@end