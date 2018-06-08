//
//  DataViewModel.h
//  MVVMDemo
//
//  Created by Apple on 2018/6/8.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewModel.h"
#import "DataModel.h"

@class DataViewModel;
@protocol DataViewModelDelegate <NSObject>

- (void)dataViewModel:(DataViewModel *)dataViewModel refreshWith:(NSIndexPath *)indexPath;

@end

@interface DataViewModel : BaseViewModel <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<DataViewModelDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *dataArray;
- (void)loadRequestServerData;

@end
