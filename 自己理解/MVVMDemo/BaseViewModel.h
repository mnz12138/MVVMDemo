//
//  BaseViewModel.h
//  MVVMDemo
//
//  Created by Apple on 2018/6/8.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import <Foundation/Foundation.h>

// 成功返回的数据
typedef void(^SuccessBlock)(void);
// 失败返回的数据
typedef void(^ErrorCodeBlock)(id errorCode);

@interface BaseViewModel : NSObject

@property (copy, nonatomic) NSString *reuseIdentifier;
@property (strong, nonatomic) SuccessBlock successBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;

// 传入交互的Block块
- (void)setBlockWithReturnBlock:(SuccessBlock)successBlock
                 errorBlock:(ErrorCodeBlock)errorBlock;
- (void)setBlockWithReuseIdentifier:(NSString *)reuseIdentifier
                       successBlock:(SuccessBlock)successBlock
                         errorBlock:(ErrorCodeBlock)errorBlock;

@end
