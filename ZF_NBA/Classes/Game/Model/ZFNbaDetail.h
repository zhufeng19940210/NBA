//
//  ZFNbaDetail.h
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface ZFNbaDetail : NSObject
/*arenaName*/
@property (nonatomic,copy)NSString *arenaName;
/*主队城市*/
@property (nonatomic,copy)NSString *Homecity;
/*主队球队名称*/
@property (nonatomic,copy)NSString *HomedisplayAbbr;
/*客队的城市*/
@property (nonatomic,copy)NSString *AwayCity;
/*客队的球队名称*/
@property (nonatomic,copy)NSString *AwaydisplayAbbr;
/*比赛时间戳*/
@property (nonatomic,copy)NSString *utcMillis;
@end
