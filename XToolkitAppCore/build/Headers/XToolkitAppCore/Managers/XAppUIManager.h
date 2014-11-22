//
//  XUIManager.h
//  TestA
//
//  Created by frank.xu on 11/19/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YISplashScreenAnimation.h"

@interface XAppUIManager : NSObject

SINGLETON_FOR_CLASS_HEADER(XAppUIManager)

@property (nonatomic, strong) UIViewController *guideViewController;
@property (nonatomic, strong) UIViewController *mainViewController;
@property (nonatomic, assign, readonly) id<UIApplicationDelegate> applicationDelegate;
@property (nonatomic, strong, readonly) UIWindow *mainWindow;

@property (nonatomic) BOOL enableLaunchAnimation;
@property (nonatomic) CGFloat launchAnimationDuration;
@property (nonatomic) CGFloat launchAnimationDelay;
@property (nonatomic) LaunchAnimationType lauchAnimationType;

- (void)initSystem;
@end
