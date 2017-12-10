//
//  ZFPlayerModel.h
//  ZF_NBA
//
//  Created by bailing on 2017/12/9.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface ZFPlayerModel : NSObject
/*姓名*/
@property (nonatomic,copy)NSString *name;
/*得分*/
@property (nonatomic,copy)NSString *socre;
/*投篮*/
@property (nonatomic,copy)NSString *toulan;
/*三分*/
@property (nonatomic,copy)NSString *sanfen;
/*罚球*/
@property (nonatomic,copy)NSString *faqiu;
/*助攻*/
@property (nonatomic,copy)NSString *zugong;
/*失误*/
@property (nonatomic,copy)NSString *siwu;
@end
