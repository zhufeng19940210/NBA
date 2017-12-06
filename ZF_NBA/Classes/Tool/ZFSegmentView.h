//
//  ZFSegmentView.h
//  ZF_NBA
//
//  Created by bailing on 2017/12/4.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFSegmentView;
@protocol ZFSegmentViewDelegate <NSObject>
-(void)dySegment:(ZFSegmentView *)segment didSelectIndex:(NSInteger)index;
@end
@interface ZFSegmentView : UIView
//设置代理
@property (weak,nonatomic)id <ZFSegmentViewDelegate> delegate;
//设置文字数组
@property (nonatomic,strong)NSArray *titleArray;
//设置文字颜色
@property (nonatomic,strong)UIColor *titleNormalColor;
//设置文字选中文字
@property (nonatomic,strong)UIColor *titleSelectColor;
//设置文字的字体
@property (nonatomic,strong)UIFont *titleFont;
//segment 默认选中的按钮
@property (nonatomic,assign)NSInteger defaultSelectIndex;
//视图偏移时，控件随着发生变化
-(void)dyDidScrollChangeTheTitleColorWithContentOfSet:(CGFloat)width;
@end
