//
//  ZFHomeNbaHeaerView.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/5.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import "ZFHomeNbaHeaerView.h"
#import "ZFLiveModel.h"
@interface  ZFHomeNbaHeaerView()
/*比分的Label*/
@property (weak, nonatomic) IBOutlet UILabel *headerScoreLabel;
/*时间的Label*/
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/*右边的战绩*/
@property (weak, nonatomic) IBOutlet UILabel *rightZhankuangLabel;
/*右边球队的名称*/
@property (weak, nonatomic) IBOutlet UILabel *rightNameLabel;
/*是否是主队*/
@property (weak, nonatomic) IBOutlet UILabel *rightWhoLabel;
/*球队的图标*/
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
/*左边的战绩*/
@property (weak, nonatomic) IBOutlet UILabel *leftZhankuangLabel;
/*左边的球队名称*/
@property (weak, nonatomic) IBOutlet UILabel *leftNameLabel;
/*是否客场*/
@property (weak, nonatomic) IBOutlet UILabel *leftWhoLabel;
/*左边球队的图片*/
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
/*比赛状态*/
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end
@implementation ZFHomeNbaHeaerView
-(void)setModel:(ZFLiveModel *)model{
    _model = model;
    self.headerScoreLabel.text = model.score;
    self.timeLabel.text = model.title;
    self.rightZhankuangLabel.text = model.player2info;
    self.rightWhoLabel.text = [NSString stringWithFormat:@"(%@)",model.player2location];
    self.rightNameLabel.text = model.player2;
    [self.rightImageView yy_setImageWithURL:[NSURL URLWithString:model.player2logobig] placeholder:nil];
    self.leftWhoLabel.text = [NSString stringWithFormat:@"(%@)",model.player1location];
    self.leftZhankuangLabel.text = model.player1info;
    self.leftNameLabel.text = model.player1;
    [self.leftImageView yy_setImageWithURL:[NSURL URLWithString:model.player1logobig] placeholder:nil];
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
}
@end
