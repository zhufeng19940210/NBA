//
//  ZFFootSubTableViewCell.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/7.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import "ZFFootSubTableViewCell.h"
@interface ZFFootSubTableViewCell()
/*c4rLabel*/
@property (weak, nonatomic) IBOutlet UILabel *c4RLabel;
/*c3Label*/
@property (weak, nonatomic) IBOutlet UILabel *c3Label;
/*c1Label*/
@property (weak, nonatomic) IBOutlet UILabel *c1Label;
/*c4t1*/
@property (weak, nonatomic) IBOutlet UILabel *c4t1Label;
/*c4t2*/
@property (weak, nonatomic) IBOutlet UILabel *c4t2Label;
/*c51Label*/
@property (weak, nonatomic) IBOutlet UILabel *c51Label;
/*c52Label*/
@property (weak, nonatomic) IBOutlet UILabel *c52Label;
@end
@implementation ZFFootSubTableViewCell

-(void)setFootModel:(ZFFootSubModel *)footModel{
    if (!footModel) {
        return;
    }
    _footModel = footModel;
    self.c4RLabel.text = footModel.c4R;
    self.c3Label.text  = footModel.c3;
    self.c1Label.text  = footModel.c1;
    self.c4t1Label.text = footModel.c4T1;
    self.c4t2Label.text = footModel.c4T2;
    self.c51Label.text = footModel.c51;
    self.c52Label.text = footModel.c52;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
