//
//  UINavigationController+CustomNavBar.m
//  CustomNavigationBarController
//
//  Created by LiJian Qiu on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UINavigationController+CustomNavBar.h"
#import "XUINavigationBar.h"

static NSString*  kIBCustomNavigationController = kDefaultNavigationNib;

@implementation UINavigationController (CustomNavBar)
+ (void)setNavibarNibName:(NSString *)nib
{
    kIBCustomNavigationController = nib;
}

+(id)navigationControllerWithRoot:(UIViewController *)root backgroundImage:(UIImage *)image barButtonItemColor:(UIColor *)bbiColor
{
  UINavigationController *navigationController = nil;
  navigationController = [[[NSBundle mainBundle] loadNibNamed:kIBCustomNavigationController 
                                                        owner:nil 
                                                      options:nil] objectAtIndex:0];
  [(XUINavigationBar *)navigationController.navigationBar setCustomStyle:CustomNavigationImage];
  [(XUINavigationBar *)navigationController.navigationBar setBackgroundWith:image];
  [(XUINavigationBar *)navigationController.navigationBar setTintColor:bbiColor];
  
  NSArray *viewControllers = [NSArray arrayWithObject:root];
  [navigationController setViewControllers:viewControllers];
  
  return navigationController;
}

+(id)navigationControllerWithRoot:(UIViewController *)root backgroundImage:(UIImage *)image
{
  UINavigationController *navigationController = nil;
  navigationController = [[[NSBundle mainBundle] 
                           loadNibNamed:kIBCustomNavigationController 
                           owner:nil options:nil] objectAtIndex:0];
  [(XUINavigationBar *)navigationController.navigationBar setCustomStyle:CustomNavigationImage];
  [(XUINavigationBar *)navigationController.navigationBar setBackgroundWith:image];
  
  NSArray *viewControllers = [NSArray arrayWithObject:root];
  [navigationController setViewControllers:viewControllers];
  
  return navigationController;
}

+(id)navigationControllerWithRoot:(UIViewController *)root backgroundColor:(UIColor *)color
{
  UINavigationController *navigationController = nil;
  
  //  available in ios 4.0+
  //  UINib *nib = [UINib nibWithNibName:kIBCustomNavigationController bundle:nil];
  //  navigationController = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
  
  //  available in ios 3.0+  
  navigationController = [[[NSBundle mainBundle] 
                           loadNibNamed:kIBCustomNavigationController 
                           owner:nil options:nil] objectAtIndex:0];
  
  [(XUINavigationBar *)navigationController.navigationBar setNavigationBarBackgroundColor:color];
  [(XUINavigationBar *)navigationController.navigationBar setCustomStyle:CustomNavigationColor];
  
  NSArray *viewControllers = [NSArray arrayWithObject:root];
  [navigationController setViewControllers:viewControllers];
  
  
  return navigationController;
}

+(id)navigationControllerWithRoot:(UIViewController *)root backgroundColor:(UIColor *)bgColor barButtonItemColor:(UIColor *)bbiColor
{
  UINavigationController *navigationController = nil;
  //  available in ios 4.0+
  //  UINib *nib = [UINib nibWithNibName:kIBCustomNavigationController bundle:nil];
  //  navigationController = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
  
  //  available in ios 3.0+  
  navigationController = [[[NSBundle mainBundle] 
                           loadNibNamed:kIBCustomNavigationController 
                           owner:nil options:nil] objectAtIndex:0];
  [(XUINavigationBar *)navigationController.navigationBar setCustomStyle:CustomNavigationColor];
  [(XUINavigationBar *)navigationController.navigationBar setNavigationBarBackgroundColor:bgColor];
  [navigationController.navigationBar setTintColor:bbiColor];
  
  NSArray *viewControllers = [NSArray arrayWithObject:root];
  [navigationController setViewControllers:viewControllers];
  
  return navigationController;
}

@end
