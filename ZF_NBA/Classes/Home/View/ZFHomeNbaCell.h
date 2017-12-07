//
//  ZFHomeNbaCell.h
//  ZF_NBA
//
//  Created by bailing on 2017/12/5.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFHomeModel.h"
@interface ZFHomeNbaCell : UITableViewCell
/*技术统计的Btn*/
@property (weak, nonatomic) IBOutlet UIButton *jishuBtn;
/*视频的Btn*/
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (nonatomic,strong) ZFHomeModel *model;

@end
