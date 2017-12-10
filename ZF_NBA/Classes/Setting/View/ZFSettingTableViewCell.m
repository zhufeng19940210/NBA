//
//  ZFSettingTableViewCell.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/9.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import "ZFSettingTableViewCell.h"
@interface ZFSettingTableViewCell()
@property (nonatomic,strong)UIView *lineView;
@end
@implementation ZFSettingTableViewCell
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}
-(UILabel *)myTittleLabel{
    if (!_myTittleLabel) {
        _myTittleLabel = [[UILabel alloc]init];
        _myTittleLabel.font = [UIFont systemFontOfSize:15];
        _myTittleLabel.textColor = [UIColor blackColor];
        _myTittleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _myTittleLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    [self.contentView addSubview:self.myTittleLabel];
    [self.contentView addSubview:self.lineView];
    self.myTittleLabel.frame = CGRectMake(8, 0, ZFScreenW, self.frame.size.height);
    self.lineView.frame = CGRectMake(0, self.frame.size.height - 0.5, ZFScreenW, 0.5);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
