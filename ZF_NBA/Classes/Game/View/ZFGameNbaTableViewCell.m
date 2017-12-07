//
//  ZFGameNbaTableViewCell.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFGameNbaTableViewCell.h"
#import "AppDelegate.h"
@interface ZFGameNbaTableViewCell()
/*球队的图标*/
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/*球队的名称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/*球队的分区*/
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
/*app对象*/
@property (nonatomic,strong) AppDelegate *app;
@end
@implementation ZFGameNbaTableViewCell
-(void)setTeamModel:(ZFTeamModel *)teamModel{
    _teamModel = teamModel;
    NSString *code = self.app.logoDict[teamModel.code];
    NSLog(@"code:%@",code);
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mat1.gtimg.com/sports/nba/logo/1602/%@.png",code]] placeholder:nil];
    self.nameLabel.text = [NSString stringWithFormat:@"%@--%@",teamModel.city,teamModel.name];
    self.areaLabel.text = teamModel.division;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.app = (AppDelegate *)[UIApplication sharedApplication].delegate;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
