//
//  XLaunchAanimation.m
//  LaunchAnimation
//
//  Created by frank.xu on 6/16/13.
//  Copyright (c) 2013 frank.xu. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "XAnimationFactory.h"

@implementation XAnimationFactory
#pragma mark Hiding Animations
+ (id)animationWithType:(XLaunchAnimationType)type duration:(CGFloat)duration
{
    switch (type) {
        case XLaunchAnimationTypeCurl:
            return [XAnimationFactory pageCurlAnimation:duration];
        case XLaunchAnimationTypeMoveFromTop:
            return [XAnimationFactory moveFromTopAnimation:duration];
        case XLaunchAnimationTypeFade:
            return [XAnimationFactory fadeAnimation:duration];
        default:
            break;
    }
    return nil;
}
+ (id)pageCurlAnimation:(CGFloat)duration
{
    if(duration == 0.0)
        duration = 2.0;
    
    void(^animationBlock)(CALayer*) = ^(CALayer* splashLayer) {
		
        // adjust anchorPoint
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        splashLayer.anchorPoint = CGPointMake(-0.0, 0.5);
        splashLayer.position = CGPointMake(splashLayer.bounds.size.width*splashLayer.anchorPoint.x, splashLayer.bounds.size.height*splashLayer.anchorPoint.y);
        [CATransaction commit];
        
        // page-curl effect
        CATransform3D transform = CATransform3DIdentity;
        float zDistanse = 800.0;
        transform.m34 = 1.0 / -zDistanse;
        
        CATransform3D transform1 = CATransform3DRotate(transform, -M_PI_2/10, 0, 1, 0);
        CATransform3D transform2 = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
        
        CAKeyframeAnimation* keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        keyframeAnimation.duration = duration;
        keyframeAnimation.values = [NSArray arrayWithObjects:
                                    [NSValue valueWithCATransform3D:transform],
                                    [NSValue valueWithCATransform3D:transform1],
                                    [NSValue valueWithCATransform3D:transform2],
                                    nil];
        keyframeAnimation.keyTimes = [NSArray arrayWithObjects:
                                      [NSNumber numberWithFloat:0],
                                      [NSNumber numberWithFloat:.2],
                                      [NSNumber numberWithFloat:1.0],
                                      nil];
        keyframeAnimation.timingFunctions = [NSArray arrayWithObjects:
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                             nil];
        keyframeAnimation.removedOnCompletion = NO;
        keyframeAnimation.fillMode = kCAFillModeForwards;
        [splashLayer addAnimation:keyframeAnimation forKey:nil];
        
	};
    
    return [animationBlock copy];
}

+ (id)moveFromTopAnimation:(CGFloat)duration
{
    if(duration == 0.0)
        duration = 1.0;
    
    void(^animationBlock)(CALayer*) = ^(CALayer* splashLayer) {
//        [CATransaction begin];
        [CATransaction setAnimationDuration:duration];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        splashLayer.position = CGPointMake(splashLayer.position.x, splashLayer.position.y-splashLayer.bounds.size.height);
        
//        [CATransaction commit];
    };
    
    return [animationBlock copy];
}

+ (id)fadeAnimation:(CGFloat)duration
{
    if(duration == 0.0)
        duration = 1.0;

    void(^fadeBlock)(CALayer *) = ^(CALayer *layer){
        [CATransaction setAnimationDuration:duration];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        layer.opacity = 0;
    };
    return [fadeBlock copy];
}
@end
