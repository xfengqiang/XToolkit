//
//  BaseControllerTest.m
//  XToolkitAppDemo
//
//  Created by frank.xu on 11/24/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "BaseReqeustControllerTest.h"

@interface BaseReqeustControllerTest ()

@end

@implementation BaseReqeustControllerTest

- (void)handleCompletion:(ASIFormDataRequest *)request doneBlock:(void(^)(ASIFormDataRequest *req, id responseData))doneBlock  systemErrorBlock:(void(^)(ASIFormDataRequest *req, NSDictionary *responseData))sysErrorBlock
{
    doneBlock(request, [request responseString]);
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)defaultBackButton
{
    UIButton *btn = [super defaultBackButton];
    return btn;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
            self.navigationController.navigationBarHidden = NO;
        // Custom initialization
    }
    return self;
}


- (IBAction)simpleRequestAction:(id)sender
{
    __unsafe_unretained typeof(self) pSelf = self;
    ASIFormDataRequest *req = [self requestWithDoneBlock:^(ASIFormDataRequest *req, id responseData) {
        NSLog(@"%@", responseData);
        [self showInfo:@"Result Ok"];
    } url:@"http://www.baidu.com" params:nil systemErrorBlock:^(ASIFormDataRequest *req, NSDictionary *responseData) {
        [pSelf showError:@"参数错误"];
    } failedBlock:^(ASIFormDataRequest *req) {
        [pSelf showError:@"请检查网络"];
    }];
    [self startRequest:req];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
