//
//  ZFTeamModel.h
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface ZFTeamModel : NSObject
@property (nonatomic,copy)NSString *abbr;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *cityEn;
@property (nonatomic,copy)NSString *code;
@property (nonatomic,copy)NSString *conference;
@property (nonatomic,copy)NSString *displayAbbr;
@property (nonatomic,copy)NSString *displayConference;
@property (nonatomic,copy)NSString *division;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *isAllStarTeam;
@property (nonatomic,assign)BOOL   *isLeagueTeam;
@property (nonatomic,copy)NSString *leagueId;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *nameEn;
@end
