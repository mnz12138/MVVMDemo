//
//  DataCell.h
//  MVVMDemo
//
//  Created by Apple on 2018/6/8.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@class DataCell;
@protocol DataCellDelegate <NSObject>

- (void)dataCell:(DataCell *)dataCell indexPath:(NSIndexPath *)indexPath;

@end

@interface DataCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) DataModel *model;
@property (nonatomic, weak) id<DataCellDelegate> delegate;

@end
