//
//  XLaunchAanimation.h
//  LaunchAnimation
//
//  Created by frank.xu on 6/16/13.
//  Copyright (c) 2013 frank.xu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    XLaunchAnimationTypeNone,
    XLaunchAnimationTypeFade, //Default
    XLaunchAnimationTypeCurl,
    XLaunchAnimationTypeMoveFromTop,
}XLaunchAnimationType;


@interface XAnimationFactory : NSObject

+ (id)animationWithType:(XLaunchAnimationType)type duration:(CGFloat)duration;
+ (id)pageCurlAnimation:(CGFloat)duration;
+ (id)fadeAnimation:(CGFloat)duration;
+ (id)moveFromTopAnimation:(CGFloat)duration;
@end
