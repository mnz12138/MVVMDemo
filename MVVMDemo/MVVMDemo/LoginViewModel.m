//
//  LoginViewModel.m
//  MVVMDemo
//
//  Created by caishihui on 2019/9/26.
//  Copyright © 2019 wqj. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initCommand];
        [self initSubscribe];
    }
    return self;
}
- (void)initCommand {
    [RACObserve(self, account) subscribeNext:^(id  _Nullable x) {
        [self checkSubmitEnable];
    }];
    [RACObserve(self, pwd) subscribeNext:^(id  _Nullable x) {
        [self checkSubmitEnable];
    }];
}
- (void)initSubscribe {
    self.loginBtnEnableCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [self racForSubmitEnable];
    }];
    self.loginActionCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [self racForLogin];
    }];
}
- (void)checkSubmitEnable {
    [self.loginBtnEnableCmd execute:nil];
}
- (RACSignal *)racForSubmitEnable {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        BOOL status = self.account.length>=3&&self.pwd.length>=3;
        [subscriber sendNext:@(status)];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (RACSignal *)racForLogin {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LoginModel *result = [[LoginModel alloc] init];
            if ([self.account isEqualToString:@"123"]&&[self.pwd isEqualToString:@"123"]) {
                //模拟请求结果
                result.userId = [NSString stringWithFormat:@"%@%@",self.account,self.pwd];
                result.displayName = result.userId;
                self.error = nil;
            }else{
                //模拟错误
                self.error = [NSError errorWithDomain:@"-1" code:-1 userInfo:@{@"des":@"账号密码错误"}];
            }
            self.loginModel = result;
            [subscriber sendNext:self];
            [subscriber sendCompleted];
        });
        return nil;
    }];
}

@end
