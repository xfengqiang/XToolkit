//
//  YISplashScreen.h
//  YISplashScreen
//
//  Created by Yasuhiro Inami on 12/06/14.
//  Copyright (c) 2012年 Yasuhiro Inami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kDefaultLaunchAnimationDuration 0.5
#define kDefaultLaunchAnimationDelay 0.5

@interface YISplashScreen : NSObject <UIAlertViewDelegate>

+ (void)setAnimationDuration:(CGFloat)duration;
+ (UIImage *)launchImage;

+ (void)show;

+ (void)hide;

+ (void)hideWithAnimations:(void (^)(CALayer* splashLayer))animations;

+ (void)hideWithAnimations:(void (^)(CALayer* splashLayer))animations
                completion:(void (^)(void))completion;

@end
