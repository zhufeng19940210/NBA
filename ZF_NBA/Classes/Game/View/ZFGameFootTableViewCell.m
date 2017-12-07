//
//  ZFGameFootTableViewCell.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFGameFootTableViewCell.h"
@interface ZFGameFootTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *footNameLabel;
@end
@implementation ZFGameFootTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setFootModel:(ZFFootModel *)footModel{
    if (!footModel) {
        return;
    }
    _footModel = footModel;
    self.iconImageView.image = [UIImage imageNamed:footModel.url];
    self.footNameLabel.text = footModel.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
