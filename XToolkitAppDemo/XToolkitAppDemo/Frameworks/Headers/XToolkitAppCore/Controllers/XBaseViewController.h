//
//  XBaseViewController.h
//  XToolkitAppCore
//
//  Created by frank.xu on 11/24/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"

@interface XBaseViewController : XNaviBaseViewController

@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic) BOOL isSearching;

//Navigation related methods


- (void)showInfo:(NSString *)info;
- (void)showError:(NSString *)error;
- (void)showWarnning:(NSString *)warnning;
- (void)showAlert:(NSString *)title message:(NSString *)message;
- (void)showWaitingView;
- (void)hideWaitingView;


//Http Request realated methods
- (void)showSystemError:(NSDictionary *)responseData;
- (void)showNetworkError:(ASIFormDataRequest *)request;
- (void)handleCompletion:(ASIFormDataRequest *)request doneBlock:(void(^)(ASIFormDataRequest *req, id responseData))doneBlock  systemErrorBlock:(void(^)(ASIFormDataRequest *req, NSDictionary *responseData))sysErrorBlock;
- (void)handleNetworkError:(ASIFormDataRequest *)request;

- (ASIFormDataRequest *)requestWithDoneBlock:(void (^)(ASIFormDataRequest *req, NSDictionary *responseData))doneBlock url:(NSString *)url;

- (ASIFormDataRequest *)requestWithDoneBlock:(void(^)(ASIFormDataRequest *reqeust, NSDictionary *responseData))doneBlock url:(NSString *)url params:(NSDictionary *)params;

- (ASIFormDataRequest *)requestWithDoneBlock:(void (^)(ASIFormDataRequest *req, NSDictionary *responseData))doneBlock url:(NSString *)url params:(NSDictionary *)params systemErrorBlock:(void(^)(ASIFormDataRequest *req, NSDictionary *responseData))sysErrorBlock;

/*
 doneBlock : 请求成功返回回调
 params : get请求参数
 sysErrorBlock : 发生系统错误（status code不ok）时回调
 failedBlock : 网络异常是回调
 */
- (ASIFormDataRequest *)requestWithDoneBlock:(void(^)(ASIFormDataRequest *req, id responseData))doneBlock
                                         url:(NSString *)url
                                      params:(NSDictionary *)params
                            systemErrorBlock:(void(^)(ASIFormDataRequest *req, NSDictionary *responseData))sysErrorBlock
                                 failedBlock:(void(^)(ASIFormDataRequest *req))failedBlock;





- (void)startRequest:(ASIFormDataRequest *)request showWaitingView:(BOOL)showWaitingView;
- (void)startRequest:(ASIFormDataRequest *)request;

- (void)cancelRequest:(ASIFormDataRequest *)request;
- (void)cancelAllRequests;
@end
