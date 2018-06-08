//
//  ViewController.m
//  MVVMDemo
//
//  Created by Apple on 2018/6/8.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import "ViewController.h"
#import "DataViewModel.h"

@interface ViewController () <DataViewModelDelegate>

@property (nonatomic, strong) DataViewModel *dataVm;

@end

@implementation ViewController
static NSString *reuseIdentifier = @"dataCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DataCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    __weak typeof(self) weakSelf = self;
    [self.dataVm setBlockWithReuseIdentifier:reuseIdentifier successBlock:^{
        [weakSelf.tableView reloadData];
    } errorBlock:^(id errorCode) {
        NSLog(@"%@",errorCode);
    }];
    self.dataVm.delegate = self;
    self.tableView.delegate = self.dataVm;
    self.tableView.dataSource = self.dataVm;
    [self.dataVm loadRequestServerData];
}

- (void)dataViewModel:(DataViewModel *)dataViewModel refreshWith:(NSIndexPath *)indexPath {
    if (indexPath) {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DataViewModel *)dataVm {
    if (!_dataVm) {
        _dataVm = [[DataViewModel alloc] init];
    }
    return _dataVm;
}

@end
