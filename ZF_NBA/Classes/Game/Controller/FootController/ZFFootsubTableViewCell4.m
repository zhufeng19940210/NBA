//
//  ZFFootsubTableViewCell4.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/7.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import "ZFFootsubTableViewCell4.h"
@interface ZFFootsubTableViewCell4()
/*排名Label*/
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
/*球队的名称Label*/
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
/*进球数量Label*/
@property (weak, nonatomic) IBOutlet UILabel *numberCountLabel;
/*黄牌数量Label*/
@property (weak, nonatomic) IBOutlet UILabel *huangpaiLabel;
@end
@implementation ZFFootsubTableViewCell4
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ZFFootSubModel4 *)model{
    _model = model;
    self.numberLabel.text= [NSString stringWithFormat:@"%d",model.c1];
    self.teamLabel.text = [NSString stringWithFormat:@"%@--%@",model.c3,model.c2];
    self.numberCountLabel.text = [NSString stringWithFormat:@"进球数:%d",model.c4];
    self.huangpaiLabel.text = [NSString stringWithFormat:@"黄牌数:%d",model.c5];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
