//
//  YISplashScreenAnimation.h
//  YISplashScreen
//
//  Created by Yasuhiro Inami on 12/06/15.
//  Copyright (c) 2012年 Yasuhiro Inami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
    ELaunchAnimationTypeFade, //Default
    ELaunchAnimationTypeCurl,
    ELaunchAnimationTypeMoveFromTop
}LaunchAnimationType;


@interface YISplashScreenAnimation : NSObject

+ (id)animationWithType:(LaunchAnimationType)type;
+ (id)pageCurlAnimation;
+ (id)moveFromTopAnimation;

@end
