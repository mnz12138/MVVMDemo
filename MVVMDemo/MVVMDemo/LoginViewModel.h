//
//  LoginViewModel.h
//  MVVMDemo
//
//  Created by caishihui on 2019/9/26.
//  Copyright © 2019 wqj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *pwd;

@property (nonatomic, strong, nullable) NSError *error;
@property (nonatomic, strong) LoginModel *loginModel;

@property (nonatomic, strong) RACCommand *loginBtnEnableCmd;
@property (nonatomic, strong) RACCommand *loginActionCmd;

@end

NS_ASSUME_NONNULL_END
