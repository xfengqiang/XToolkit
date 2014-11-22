//
//  FirstViewController.m
//  XToolkitAppDemo
//
//  Created by frank.xu on 11/21/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "FirstViewController.h"
#import "BaseReqeustControllerTest.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addTestItem:[TestRowItem itemWithController:@"BaseControllerTest" nib:@"BaseControllerTest" title:@"Test XBaseViewController"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
