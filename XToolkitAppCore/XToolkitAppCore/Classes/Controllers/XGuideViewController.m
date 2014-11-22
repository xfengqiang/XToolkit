//
//  XGuideViewController.m
//  AutoSizeTest
//
//  Created by frank.xu on 11/19/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "XGuideViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface XGuideViewController () <UIScrollViewDelegate>
@property (nonatomic, strong, readwrite) UIViewController *rootController;
@end

#define kNotFisrtLanchKey @"kNotFisrtLanchKey"

@implementation XGuideViewController
@synthesize scrollView;
@synthesize pageControl;

#pragma mark - View lifecycle

+ (BOOL)isFirstLaunch
{
    return ![[NSUserDefaults standardUserDefaults] boolForKey:kNotFisrtLanchKey];
}

+ (void)setFirstLaunchTag
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kNotFisrtLanchKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)clearFirstLaunchTag
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kNotFisrtLanchKey];
}

- (id)initWithNibName:(NSString *)nibNameOrNil rootController:(UIViewController *)rootController
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nil])
    {
        self.rootController = rootController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 4, self.view.frame.size.height);
}

- (void)viewDidAppear:(BOOL)animated
{
    pageControl.numberOfPages = self.scrollView.contentSize.width/CGRectGetWidth(self.scrollView.frame);
    pageControl.currentPage =0;
    NSLog(@"self.scrollView.contentSize.width:%f", self.scrollView.contentSize.width);
    [super viewDidAppear:animated];
}

- (IBAction)gotoMainView:(id)sender {
    //进入主界面
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.type = kCATransitionFade;
    [animation setDelegate:self];
    [self.view.layer addAnimation:animation forKey:@"animation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.rootController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:self.rootController animated:YES];
    [XGuideViewController setFirstLaunchTag];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.view.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) +1;
    pageControl.currentPage = page;
}

@end
