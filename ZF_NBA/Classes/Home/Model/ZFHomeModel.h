//
//  ZFHomeModel.h
//  ZF_NBA
//
//  Created by bailing on 2017/12/5.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface ZFHomeModel : NSObject
@property (nonatomic,copy)NSString *link1text; //视频集锦
@property (nonatomic,copy)NSString *link1url;  //视频集锦的url
@property (nonatomic,copy)NSString *link2text; // 技术统计
@property (nonatomic,copy)NSString *link2url;  // 技术统计的url
@property (nonatomic,copy)NSString *m_link1url;
@property (nonatomic,copy)NSString *m_link2url;
@property (nonatomic,copy)NSString *player1;
@property (nonatomic,copy)NSString *player1logo;
@property (nonatomic,copy)NSString *player1logobig;
@property (nonatomic,copy)NSString *player1url;
@property (nonatomic,copy)NSString *player2;
@property (nonatomic,copy)NSString *player2logo;
@property (nonatomic,copy)NSString *player2logobig;
@property (nonatomic,copy)NSString *player2url;
@property (nonatomic,copy)NSString *score;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *time;
@end
