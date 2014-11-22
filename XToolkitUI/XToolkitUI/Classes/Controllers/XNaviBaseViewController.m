//
//  XNaviBaseViewController.m
//  XToolKitUIDemo
//
//  Created by frank.xu on 11/25/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "XNaviBaseViewController.h"
#import "XUINavigationBar.h"

@interface XNaviBaseViewController ()

@end

@implementation XNaviBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIButton *)defaultBackButton
{
    if (!_defaultBackButton)
    {
        XUINavigationBar *customNavigationBar = (XUINavigationBar *)self.navigationController.navigationBar;
        UIButton  *backButton = [customNavigationBar backButtonWith:[UIImage imageNamed:@"back_normal.png"]
                                                          highlight:[UIImage imageNamed:@"back_pressed"] leftCapWidth:100 title:nil];
        _defaultBackButton = backButton;
    }
    return _defaultBackButton;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.navigationItem.leftBarButtonItem.customView
        && [[self.navigationController viewControllers] objectAtIndex:0] != self )
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self defaultBackButton]] ;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
