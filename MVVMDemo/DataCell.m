//
//  DataCell.m
//  MVVMDemo
//
//  Created by Apple on 2018/6/8.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import "DataCell.h"
#import <ReactiveObjC.h>

@interface DataCell ()

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation DataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(DataModel *)model {
    _model = model;
    
    self.numLabel.text = [NSString stringWithFormat:@"%ld",model.num];
}
- (IBAction)reductionAction {
    self.model.num--;
    [self noticeDelegateEvent];
}
- (IBAction)addAction {
    self.model.num++;
    [self noticeDelegateEvent];
}

- (void)noticeDelegateEvent {
    if ([self.delegate respondsToSelector:@selector(dataCell:indexPath:)]) {
        [self.delegate dataCell:self indexPath:self.indexPath];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
