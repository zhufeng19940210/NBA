//
//  ZFHomeNbaCell.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/5.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import "ZFHomeNbaCell.h"
@interface ZFHomeNbaCell ()
/*分数的label*/
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
/*right的imgeView*/
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
/*left的imageView*/
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
/*right的球队的Label*/
@property (weak, nonatomic) IBOutlet UILabel *rightNameLabel;
/*left的球队的Label*/
@property (weak, nonatomic) IBOutlet UILabel *leftNameLabel;
/*状态的Label*/
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
/*时间的Label*/
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
@implementation ZFHomeNbaCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setModel:(ZFHomeModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    self.scoreLabel.text = model.score;
    [self.rightImageView yy_setImageWithURL:[NSURL URLWithString:model.player2logo] placeholder:nil];
    self.rightNameLabel.text = model.player2;
    [self.leftImageView yy_setImageWithURL:[NSURL URLWithString:model.player1logo] placeholder:nil];
    self.leftNameLabel.text = model.player1;
    if ([model.status isEqualToString:@"2"]) {
        self.statusLabel.text = @"已结束";
        self.statusLabel.textColor = [UIColor whiteColor];
        self.statusLabel.backgroundColor = [UIColor grayColor];
    }else if ([model.status isEqualToString:@"1"]){
        self.statusLabel.text = @"正在进行";
        self.statusLabel.textColor = [UIColor whiteColor];
        self.statusLabel.backgroundColor = [UIColor redColor];
    }else{
        self.statusLabel.text = @"未开始";
        self.statusLabel.textColor = [UIColor whiteColor];
        self.statusLabel.backgroundColor = [UIColor blueColor];
    }
    self.timeLabel.text = model.time;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
