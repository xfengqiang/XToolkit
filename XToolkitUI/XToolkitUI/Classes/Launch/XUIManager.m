//
//  XUIManager.m
//  HelloWorld
//
//  Created by frank.xu on 6/16/13.
//  Copyright (c) 2013 frank.xu. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "XAnimationFactory.h"
#import "XUIManager.h"

#define kFirstLaunchKey @"XFirstLanunchKey"

@interface XUIManager()
@property (nonatomic, strong) UIWindow *splashWindow;
@property (nonatomic) BOOL statusBarHidden;

@end

@implementation XUIManager

SINGLETON_FOR_CLASS_IMPLEMENTION(XUIManager)

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

- (id)init
{
    if (self = [super init]) {
        self.launchAnimationType = XLaunchAnimationTypeCurl;
    }
    return self;
}

- (id<UIApplicationDelegate>)applicationDelegate
{
    return [UIApplication sharedApplication].delegate;
}

- (UIWindow *)window
{
    return [UIApplication sharedApplication].delegate.window;
}

- (BOOL)isFirstLaunch
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kFirstLaunchKey];
}

- (void)setFirstLaunch:(BOOL)flag
{
    [[NSUserDefaults standardUserDefaults] setBool:flag forKey:kFirstLaunchKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)start
{
    UIWindow *mainWindow = [UIApplication sharedApplication].delegate.window;
    if(!mainWindow)
    {
        mainWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [UIApplication sharedApplication].delegate.window = mainWindow;
    }
    
    if([self isFirstLaunch] && self.guideViewController)
    {
//        UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:self.guideViewController];
        mainWindow.rootViewController = self.guideViewController;
    }
    else
        mainWindow.rootViewController = self.mainViewController;
    
    [mainWindow addSubview:mainWindow.rootViewController.view];
    if (!mainWindow.isKeyWindow)
    {
        [mainWindow makeKeyAndVisible];
    }
    [self showLaunchAnimation:nil];
}
- (void)showLaunchAnimation:(void(^)(void))completion
{
    if(self.launchAnimationType == XLaunchAnimationTypeNone)
        return ;
    
    UIWindow *window  = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window setWindowLevel:UIWindowLevelStatusBar+1];
    window.backgroundColor = [UIColor greenColor];
    self.splashWindow = window;
    
    UIViewController *tmpController = [[UIViewController alloc]
                                       initWithNibName:nil bundle:nil];
    [tmpController setWantsFullScreenLayout:YES];
    window.rootViewController = tmpController;
    tmpController.view.backgroundColor = [UIColor clearColor];
    window.backgroundColor = [UIColor clearColor];
    [window makeKeyAndVisible];
    self.splashWindow = window;
    
    CALayer * layer = [CALayer layer];
    layer.contents = (__bridge id)([XUIManager launchImage].CGImage);
    layer.frame = window.bounds;
    [tmpController.view.layer addSublayer:layer];

    if (self.launchAnimationDelay > 0) {
        int64_t delayInSeconds = self.launchAnimationDelay;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self showAniamtion:layer comletion:completion];
        });
    }
    else
        [self showAniamtion:layer comletion:completion];
}

- (void)showAniamtion:(CALayer *)layer comletion:(void(^)(void))completion
{
    void(^animationBlock)(CALayer *) = [XAnimationFactory animationWithType:self.launchAnimationType duration:self.launchAnimationDuration];
    
    
    [CATransaction flush];
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [self.splashWindow resignKeyWindow];
        self.splashWindow = nil;
        [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
        [[UIApplication sharedApplication].delegate.window becomeKeyWindow];
//        if (self.statusBarHidden == NO) {
//            [[UIApplication sharedApplication] setStatusBarHidden:NO];
//        }
        if(completion)
            completion();
    }];
    
    if(animationBlock)
        animationBlock(layer);
    
    [CATransaction commit];
}

- (void)goToMainController:(UIViewController *) fromController
{
    self.mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [fromController presentModalViewController:self.mainViewController animated:YES];
    [self setFirstLaunch:NO];
}
@end
