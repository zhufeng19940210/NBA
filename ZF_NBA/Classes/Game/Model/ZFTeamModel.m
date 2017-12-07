//
//  ZFTeamModel.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFTeamModel.h"
@implementation ZFTeamModel
//返回一个Dict,将model属性名称隐射key和value
+(NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"ID" : @[@"id"]
             };
}
-(NSString *)description{
    
    return [self yy_modelDescription];
}
@end
