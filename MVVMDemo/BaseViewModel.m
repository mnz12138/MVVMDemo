//
//  BaseViewModel.m
//  MVVMDemo
//
//  Created by Apple on 2018/6/8.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

#pragma 接收传过来的block
- (void)setBlockWithReturnBlock:(SuccessBlock)successBlock errorBlock:(ErrorCodeBlock)errorBlock {
    _successBlock = successBlock;
    _errorBlock = errorBlock;
}

- (void)setBlockWithReuseIdentifier:(NSString *)reuseIdentifier successBlock:(SuccessBlock)successBlock errorBlock:(ErrorCodeBlock)errorBlock {
    [self setBlockWithReturnBlock:successBlock errorBlock:errorBlock];
    _reuseIdentifier = reuseIdentifier;
}

@end
