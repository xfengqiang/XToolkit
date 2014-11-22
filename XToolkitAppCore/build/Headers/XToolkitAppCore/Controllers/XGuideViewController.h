//
//  XGuideViewController.h
//  AutoSizeTest
//
//  Created by frank.xu on 11/19/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGuideViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootController;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

+ (BOOL)isFirstLaunch;
+ (void)clearFirstLaunchTag;

- (id)initWithNibName:(NSString *)nibNameOrNil rootController:(UIViewController *)rootController;

- (IBAction)gotoMainView:(id)sender;

@end
