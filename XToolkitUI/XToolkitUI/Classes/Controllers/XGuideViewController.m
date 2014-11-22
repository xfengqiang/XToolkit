//
//  XGuideViewController.m
//  LaunchAnimation
//
//  Created by frank.xu on 6/16/13.
//  Copyright (c) 2013 frank.xu. All rights reserved.
//

#import "XGuideViewController.h"
#import "XUIManager.h"

@interface XGuideViewController ()

@end

@implementation XGuideViewController

- (void)toMainView
{
    XUIManager *uiMgr = [XUIManager sharedInstance];
    uiMgr.mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:uiMgr.mainViewController animated:YES];
    [uiMgr setFirstLaunch:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
