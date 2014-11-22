//
//  XUIManager.h
//  HelloWorld
//
//  Created by frank.xu on 6/16/13.
//  Copyright (c) 2013 frank.xu. All rights reserved.
//
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import "XUtilDefine.h"
#import "XAnimationFactory.h"

@interface XUIManager : NSObject
SINGLETON_FOR_CLASS_HEADER(XUIManager)

@property (nonatomic) float launchAnimationDuration;
@property (nonatomic) float launchAnimationDelay;
@property (nonatomic) XLaunchAnimationType launchAnimationType;
@property (nonatomic, assign, readonly) id<UIApplicationDelegate> applicationDelegate;
@property (nonatomic, assign, readonly) UIWindow *window;

@property (nonatomic, strong) UIViewController *mainViewController;
@property (nonatomic, strong) UIViewController *guideViewController;

- (BOOL)isFirstLaunch;
- (void)setFirstLaunch:(BOOL)flag;

+ (UIImage *)launchImage;

- (void)start;
- (void)showLaunchAnimation:(void(^)(void))completion;
- (void)goToMainController:(UIViewController *) fromController;
@end
