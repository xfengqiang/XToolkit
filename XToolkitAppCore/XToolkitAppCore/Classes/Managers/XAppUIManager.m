//
//  XUIManager.m
//  TestA
//
//  Created by frank.xu on 11/19/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "XAppUIManager.h"
#import "YISplashScreen.h"

@interface XAppUIManager()
@end

@implementation XAppUIManager

SINGLETON_FOR_CLASS_IMPLEMENTION(XAppUIManager)

@dynamic applicationDelegate;

- (id)init
{
    if (self = [super init])
    {
        self.enableLaunchAnimation = YES;
        self.launchAnimationDuration = kDefaultLaunchAnimationDuration;
        self.launchAnimationDelay = kDefaultLaunchAnimationDelay;
        self.lauchAnimationType = ELaunchAnimationTypeFade;
    }
    return self;
}
- (id<UIApplicationDelegate>)applicationDelegate
{
    return [UIApplication sharedApplication].delegate;
}

- (UIWindow *)mainWindow
{
    return self.applicationDelegate.window;
}

- (void)startApp
{
    if (!self.enableLaunchAnimation)
    {
        return;
    }
    
    [YISplashScreen show];
    [YISplashScreen hideWithAnimations:[YISplashScreenAnimation animationWithType:self.lauchAnimationType]];
}

- (void)initSystem
{
    NSAssert(self.mainViewController != nil, @"Main view controller can't be nil.");
    self.applicationDelegate.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIViewController *rootController = nil;
    if (self.guideViewController)
    {
        rootController = self.guideViewController;
    }
    else 
    {
        rootController = self.mainViewController;
    }
    self.mainWindow.rootViewController = rootController;
    
    [self startApp];
    [self.mainWindow makeKeyAndVisible];
}

@end
