//
//  DataViewModel.m
//  MVVMDemo
//
//  Created by Apple on 2018/6/8.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import "DataViewModel.h"
#import "DataCell.h"

@interface DataViewModel () <DataCellDelegate>

@end

@implementation DataViewModel

- (void)loadRequestServerData {
    [self.dataArray removeAllObjects];
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i=0; i<20; i++) {
        DataModel *model = [[DataModel alloc] init];
        [array addObject:model];
    }
    [self.dataArray addObjectsFromArray:array];
    if (self.successBlock) {
        self.successBlock();
    }
}

- (void)dataCell:(DataCell *)dataCell indexPath:(NSIndexPath *)indexPath {
    //此处有可能请求网络(如：点击cell上的赞)
    //可以在协议方法中加入具体事件的枚举，在此处进行判断处理
    if ([self.delegate respondsToSelector:@selector(dataViewModel:refreshWith:)]) {
        [self.delegate dataViewModel:self refreshWith:indexPath];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DataCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    DataCell *dataCell = (DataCell *)cell;
    dataCell.model = self.dataArray[indexPath.row];
    dataCell.indexPath = indexPath;
    dataCell.delegate = self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
