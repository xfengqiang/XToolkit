//
//  XBaseViewController.m
//  XToolkitAppCore
//
//  Created by frank.xu on 11/24/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import "XBaseViewController.h"

@interface XBaseViewController ()
{
}

@property (nonatomic, strong) NSMutableArray *asiRequests;
@property (nonatomic, strong) UIView *waitingView;
@end


@implementation XBaseViewController
- (NSMutableArray *)searchResults
{
    if (!_searchResults)
    {
        _searchResults = [NSMutableArray array];
    }
    return _searchResults;
}

- (void)showInfo:(NSString *)info
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = info;
    hud.margin = 10.f;
    hud.yOffset = 0.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:2];
}

- (void)showError:(NSString *)error
{
    [self showInfo:error];
}

- (void)showWarnning:(NSString *)warnning
{
    [self showInfo:warnning];
}

- (void)showAlert:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
    [alertView show];
}

- (void)showWaitingView
{
    [self.waitingView removeFromSuperview];
    MBProgressHUD *hud =[[MBProgressHUD alloc] initWithView:self.view];
    self.waitingView = hud;
	[self.view addSubview:hud];
    [hud show:YES];
}

- (void)hideWaitingView
{
    [(MBProgressHUD *)self.waitingView hide:YES afterDelay:0.25];
}

- (void)showSystemError:(NSDictionary *)responseData
{
    NSString *errorInfo = [responseData objectForKey:@"return_info"];
    NSInteger errorCode = [[responseData objectForKey:@"error_code"] integerValue];
    if (errorInfo.length == 0)
    {
        errorInfo = @"未知错误";
    }else{
        [self showInfo:errorInfo];
    }
    //[self showInfo:errorInfo];
    
    NSLog(@"system error: info:%@ code:%d response:%@", errorInfo, errorCode, responseData);
}

- (void)showNetworkError:(ASIFormDataRequest *)request
{
    NSLog(@"请求失败：%@", request.error);
    [self showInfo:@"网络异常"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationController setNavigationBarHidden:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - HttpRequest Releated
- (ASIFormDataRequest *)requestWithDoneBlock:(void (^)(ASIFormDataRequest *req, NSDictionary *responseData))doneBlock url:(NSString *)url
{
    return [self requestWithDoneBlock:doneBlock url:url params:nil];
}

- (ASIFormDataRequest *)requestWithDoneBlock:(void (^)(ASIFormDataRequest *req, NSDictionary *responseData))doneBlock url:(NSString *)url params:(NSDictionary *)params
{
    return [self requestWithDoneBlock:doneBlock
                                  url:url params:params
                     systemErrorBlock:^(ASIFormDataRequest *req, NSDictionary *responseData) {
                         [self showSystemError:responseData];
                     }];
}

- (ASIFormDataRequest *)requestWithDoneBlock:(void (^)(ASIFormDataRequest *req, NSDictionary *responseData))doneBlock url:(NSString *)url params:(NSDictionary *)params systemErrorBlock:(void(^)(ASIFormDataRequest *req, NSDictionary *responseData))sysErrorBlock
{
    __unsafe_unretained typeof(self) pSelf = self;
    return [self requestWithDoneBlock:doneBlock
                                  url:url
                               params:params
                     systemErrorBlock:sysErrorBlock failedBlock:^(ASIFormDataRequest *req) {
                         [pSelf showNetworkError:req];
                     }];
}


- (void)startRequest:(ASIFormDataRequest *)request showWaitingView:(BOOL)showWaitingView
{
    if (showWaitingView)
    {
        [self showWaitingView];
    }
    [request startAsynchronous];
}

- (void)startRequest:(ASIFormDataRequest *)request
{
    [self startRequest:request showWaitingView:YES];
}


- (ASIFormDataRequest *)requestWithDoneBlock:(void(^)(ASIFormDataRequest *req, id responseData))doneBlock url:(NSString *)url  params:(NSDictionary *)params systemErrorBlock:(void(^)(ASIFormDataRequest *req, NSDictionary *responseData))sysErrorBlock failedBlock:(void(^)(ASIFormDataRequest *req))failedBlock
{

//    [ASIHTTPRequest setDefaultTimeOutSeconds:180]; //设置超时时间为3分钟
    NSMutableString *requestUrl = [NSMutableString stringWithString:url];
    
    //添加URL请求参数，貌似用不到。。。
    if (params && params.allKeys.count > 0)
    {
        NSMutableArray *paramsArray = [NSMutableArray arrayWithCapacity:params.count];
        for (NSString *key in params)
        {
            id value  = [params objectForKey:key];
            [paramsArray addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
        }
        
        [requestUrl appendFormat:@"/%@", [paramsArray componentsJoinedByString:@"&"]];
    }
    
    NSLog(@"requst URL:%@", requestUrl);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    __block ASIFormDataRequest*pRequest = request;
    __unsafe_unretained typeof(self) pSelf = self;
    [request setCompletionBlock:
     ^{
         [pSelf hideWaitingView];
         [pSelf handleCompletion:pRequest doneBlock:doneBlock systemErrorBlock:sysErrorBlock];
     }];
    
    [request setUseCookiePersistence:YES];
    [request setFailedBlock:^{
        failedBlock(pRequest);
        [pSelf hideWaitingView];
    }];
    
    [self.asiRequests addObject:request];
    return request;
}


- (void)cancelRequest:(ASIFormDataRequest *)request
{
    if (!request)
    {
        return ;
    }
    [request clearDelegatesAndCancel];
    [self.asiRequests removeObject:request];
}

- (void)cancelAllRequests
{
    for (ASIFormDataRequest *request in self.asiRequests)
    {
        [request clearDelegatesAndCancel];
    }
    [self.asiRequests removeAllObjects];
}

- (void)handleCompletion:(ASIFormDataRequest *)request doneBlock:(void(^)(ASIFormDataRequest *req, id responseData))doneBlock  systemErrorBlock:(void(^)(ASIFormDataRequest *req, NSDictionary *responseData))sysErrorBlock
{
    NSDictionary *dict = [[request responseData] objectFromJSONData];
    NSNumber *number = [dict objectForKey:@"status"];
    BOOL resultsOk = YES;
    if (number) //如果没有返回status，则认为请求成功返回
    {
        resultsOk = [number boolValue];
    }
    if (resultsOk)
    {
        NSLog(@"result ok:%@", dict);
        doneBlock(request, dict);
    }
    else
    {
        sysErrorBlock(request, dict);
    }
}

- (void)handleNetworkError:(ASIFormDataRequest *)request
{
    NSLog(@"Http reqeust failed url:%@", request.url);
    [self showNetworkError:request];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self cancelAllRequests];
}
@end
