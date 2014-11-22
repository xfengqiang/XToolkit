//
//  RequestUtil.m
//  FAWAuto
//
//  Created by frank.xu on 11/3/12.
//  Copyright (c) 2012 YIN. All rights reserved.
//

#import "RequestUtil.h"


@interface RequestUtil()
@end

@implementation RequestUtil

+ (NSString *)fullUrlByAppendPath:(NSString *)path
{
    return [kAPIServerHost stringByAppendingFormat:@"/ajax/%@",path];
}

+ (NSURL *)imageURLWithPath:(NSString *)path
{
    if ([path hasPrefix:@"http:"])
    {
        return [NSURL URLWithString:path];
    }
    
    NSString *addr = [kAPIServerHost stringByAppendingFormat:@"/%@", path];
    return [NSURL URLWithString:addr];
}
@end
