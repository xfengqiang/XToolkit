//
//  YISplashScreen.m
//  YISplashScreen
//
//  Created by Yasuhiro Inami on 12/06/14.
//  Copyright (c) 2012年 Yasuhiro Inami. All rights reserved.
//

#import "YISplashScreen.h"


static UIViewController* __originalRootViewController = nil;
static UIWindow* __splashWindow = nil;
static CALayer* __splashLayer = nil;
static CGFloat __defaultAnimationDuration = 0.5;

@implementation YISplashScreen

+ (void)setAnimationDuration:(CGFloat)duration
{
    if (duration > 0)
    {
        __defaultAnimationDuration = duration;
    }
}

+ (UIImage *)launchImage
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *launchImageFile = [infoDictionary objectForKey:@"UILaunchImageFile"];
    
    if (launchImageFile.length == 0)
    {
        launchImageFile = [infoDictionary objectForKey:@"UILaunchImageFile~iphone"];
    }
    
    if (launchImageFile.length == 0)
    {
        launchImageFile = @"Default.png";
    }
    
    return [UIImage imageNamed:launchImageFile];
}


+ (void)show
{
    UIWindow* window = [UIApplication sharedApplication].delegate.window;
    
    // temporally disable rootViewController 
    // to avoid calling any CoreData logic while showing splash image
    __originalRootViewController = window.rootViewController;
    window.rootViewController = nil;
    
    // splash window
    UIWindow* splashWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    splashWindow.windowLevel = UIWindowLevelStatusBar+1; 
    splashWindow.backgroundColor = [UIColor clearColor]; 
    
    // splash layer (portrait)
    // TODO: show/hide landscape splash image
    CALayer* splashLayer = [CALayer layer];
    splashLayer.contents = (__bridge id)([YISplashScreen launchImage].CGImage);
    splashLayer.frame = [UIScreen mainScreen].bounds;
    [splashWindow.layer addSublayer:splashLayer];
    
    __splashWindow = splashWindow;
    __splashLayer = splashLayer;
    
    [splashWindow makeKeyAndVisible];
}

+ (void)hide
{
    [self hideWithAnimations:NULL completion:NULL];
}

+ (void)hideWithAnimations:(void (^)(CALayer* splashLayer))animations
{
    [self hideWithAnimations:animations completion:NULL];
}

+ (void)hideWithAnimations:(void (^)(CALayer* splashLayer))animations
                completion:(void (^)(void))completion
{
    // restore rootViewController here
    UIWindow* window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = __originalRootViewController;
    
    //
    // NOTE:
    // [CATransaction flush] (or running run loop once) is required
    // for inside-animations-block to perform implicit/explicit transactions.
    //
    [CATransaction flush];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        
        [window makeKeyAndVisible];
        
        // clean up
        __splashLayer = nil;
        __splashWindow = nil;
        __originalRootViewController = nil;
        
        if (completion) {
            completion();
        }
    }];
    
    
    if (animations) {
        animations(__splashLayer);
    }
    else {
        // default: fade out
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.5];
        __splashLayer.opacity = 0;
        [CATransaction commit];
    }
    
    [CATransaction commit];
}

@end
