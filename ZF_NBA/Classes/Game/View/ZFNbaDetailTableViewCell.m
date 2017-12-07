//
//  ZFNbaDetailTableViewCell.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFNbaDetailTableViewCell.h"
@interface  ZFNbaDetailTableViewCell()
/*球馆*/
@property (weak, nonatomic) IBOutlet UILabel *arryNameLabel;
/*时间*/
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/*客场的city*/
@property (weak, nonatomic) IBOutlet UILabel *awayCityLabel;
/*客场的球队名称*/
@property (weak, nonatomic) IBOutlet UILabel *awayNameLabel;
/*主队的city*/
@property (weak, nonatomic) IBOutlet UILabel *homeCityLabel;
/*主队的球队名称*/
@property (weak, nonatomic) IBOutlet UILabel *homeNameLabel;
@end
@implementation ZFNbaDetailTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setDetail:(ZFNbaDetail *)detail{
    if (!detail) {
        return;
    }
    _detail = detail;
    self.arryNameLabel.text = detail.arenaName;
    NSTimeInterval time = [detail.utcMillis doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time/1000];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
    NSLog(@"currentDateStr:%@",currentDateStr);
    self.timeLabel.text  = [NSString stringWithFormat:@"北京时间:%@",currentDateStr];
    self.awayCityLabel.text = detail.AwayCity;
    self.awayNameLabel.text = detail.AwaydisplayAbbr;
    self.homeCityLabel.text = detail.Homecity;
    self.homeNameLabel.text = detail.HomedisplayAbbr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
