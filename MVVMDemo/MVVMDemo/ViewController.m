//
//  ViewController.m
//  MVVMDemo
//
//  Created by caishihui on 2019/9/26.
//  Copyright © 2019 wqj. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtAccount;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;

@property (nonatomic, strong) LoginViewModel *loginVm;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //双向绑定
    [self initCommand];
    [self initSubscribe];
    //kvo监听数据回调
    //[self bindViewModel];
}
- (IBAction)loginAction {
    [self.loginVm.loginActionCmd execute:nil];
}
- (void)initCommand {
    RAC(self.loginVm, account) = self.txtAccount.rac_textSignal;
    RAC(self.loginVm, pwd) = self.txtPwd.rac_textSignal;
}
- (void)initSubscribe {
    [[self.loginVm.loginBtnEnableCmd.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        self.btnSubmit.enabled = [x boolValue];
        self.lblResult.text = @"";
    }];
    //监听当前命令是否正在执行executing
    //监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号(刚启动会有一次信号)
    //x:YES 当前cmd正在触发执行
    //x:NO 当前cmd不处于执行状态/或已处理完成
    [[self.loginVm.loginActionCmd.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            //[SVProgressHUD showWithStatus:@"正在请求"];
            NSLog(@"正在请求");
        }else{
            //[SVProgressHUD showSuccessWithStatus:@"加载完毕"];
            NSLog(@"加载完毕");
        }
    }];
    //监听数据回调
    [[self.loginVm.loginActionCmd.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        LoginViewModel *loginViewModel = x;
        if (!loginViewModel) {
            return;
        }
        if (loginViewModel.error) {
            //错误信息自行处理
            self.lblResult.text = [NSString stringWithFormat:@"%@",loginViewModel.error.userInfo[@"des"]];
//            [SVProgressHUD showInfoWithStatus:@"登录失败"];
            NSLog(@"登录失败");
        }else{
            self.lblResult.text = loginViewModel.loginModel.userId;
//            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            NSLog(@"登录成功");
        }
    }];
}
- (void)bindViewModel {
    [RACObserve(self.loginVm, loginModel) subscribeNext:^(id  _Nullable x) {
        LoginViewModel *loginViewModel = x;
        if (!loginViewModel) {
            return;
        }
        if (loginViewModel.error) {
            //错误信息自行处理
            self.lblResult.text = [NSString stringWithFormat:@"%@",loginViewModel.error.userInfo[@"des"]];
//            [SVProgressHUD showInfoWithStatus:@"登录失败"];
            NSLog(@"登录失败");
        }else{
            self.lblResult.text = loginViewModel.loginModel.userId;
//            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            NSLog(@"登录成功");
        }
    }];
}
- (LoginViewModel *)loginVm {
    if (!_loginVm) {
        _loginVm = [[LoginViewModel alloc] init];
    }
    return _loginVm;
}

@end
