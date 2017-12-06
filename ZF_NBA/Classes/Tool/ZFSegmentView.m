//
//  ZFSegmentView.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/4.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFSegmentView.h"
@interface ZFSegmentView()
/*Segemnt的高度*/
@property (nonatomic,assign)CGFloat segmentHeight;
/*Segment的宽度*/
@property (nonatomic,assign)CGFloat segmentWidth;
/*Segment的button的宽度*/
@property (nonatomic,assign)CGFloat btnWidth;
/*btn的数组*/
@property (nonatomic,strong)NSMutableArray *btnArray;
/*Scollview的东西*/
@property (nonatomic,strong)UIScrollView  *bgScrollView;
/*底部的lineview*/
@property (nonatomic,strong)UIView *bottomLine;
/*选择的btn*/
@property (nonatomic,strong)UIButton *selectBtn;
@end
@implementation ZFSegmentView
-(UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.segmentWidth, self.frame.size.height)];
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _bgScrollView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.segmentHeight = frame.size.height;
        NSLog(@"self.segmentHeight:%f",self.segmentHeight);
        self.segmentWidth = frame.size.width;
        NSLog(@"self.segmentWidth:%f",self.segmentWidth);
        self.titleFont = [UIFont systemFontOfSize:15];
        self.btnArray  = [NSMutableArray array];
        self.titleNormalColor = [UIColor whiteColor];
        self.defaultSelectIndex = 1;
        //添加控件了
        [self addSubview:self.bgScrollView];
        [self registerKVOPaths];
        //监测滚动
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mainViewScrollDidScroll:) name:@"MainViewScrollDidScroll" object:nil];
    }
    return self;
}
//滚动的推送
-(void)mainViewScrollDidScroll:(NSNotification *)noti{
    UIButton *butotn = [self viewWithTag:[noti.object integerValue]];
    if (butotn.tag == self.defaultSelectIndex) {
        return;
    }else{
        self.selectBtn.selected = NO;
        butotn.selected = YES;
        self.selectBtn = butotn;
        self.defaultSelectIndex = butotn.tag;
    }
}
// 注册KVOPath的监听了
-(void)registerKVOPaths{
    for (NSString *keyPath in [self observeKeyPaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}
// 监测的keypath
-(NSArray *)observeKeyPaths{
    NSArray *pathArr = [NSArray arrayWithObjects:@"titleNormalColor",@"titleSelectColor",@"titleFont",@"defaultSelectIndex", nil];
    return pathArr;
}
#pragma mark - kvo的监听方法 执行的代码
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self updateUIWithNewValueOfKeypath:keyPath];
}
// 根据keypath来执行响应的操作了
-(void)updateUIWithNewValueOfKeypath:(NSString *)keypath{
    if ([keypath isEqualToString:@"titleNormalColor"]) {
        [self updateSegmentViewUi:^(UIButton *btn) {
            [btn  setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        }];
    }else if ([keypath isEqualToString:@"titleSelectColor"]){
        [self updateSegmentViewUi:^(UIButton *btn) {
            [btn setTitleColor:self.titleSelectColor forState:UIControlStateNormal];
        }];
    }else if ([keypath isEqualToString:@"titleFont"]){
        [self updateSegmentViewUi:^(UIButton *btn) {
            btn.titleLabel.font = self.titleFont;
        }];
    }else if ([keypath isEqualToString:@"defaultSelectIndex"]){
        [self updateSegmentViewUi:^(UIButton *btn) {
            if (btn.tag == self.defaultSelectIndex) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
        }];
    }
    [self setNeedsLayout]; //标记需要刷新
    [self layoutIfNeeded]; //刷新界面
}
// 更加keypath来做响应的更新ui操作
-(void)updateSegmentViewUi:(void(^)(UIButton *btn))complete{
    for (UIButton *btn in self.btnArray) {
        [btn setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.titleSelectColor forState:UIControlStateNormal];
        btn.titleLabel.font = self.titleFont;
        if (complete) {
            complete(btn);
        }
    }
}
// 设置titleArray
-(void)setTitleArray:(NSArray *)titleArray{
    if (!titleArray) {
        return;
    }
    _titleArray = titleArray;
    self.bottomLine = [[UIView alloc]initWithFrame:CGRectMake(self.segmentWidth/4.0-ZF_LINE_WIDTH/2.0+(self.defaultSelectIndex-1)*(ZF_LINE_WIDTH+self.segmentWidth/2.0), self.segmentHeight-4, ZF_LINE_WIDTH, 1)];
    self.bottomLine.backgroundColor = [UIColor redColor];
    [self.bgScrollView addSubview:self.bottomLine];
    //设置scrollview的偏移量
    self.bgScrollView.contentSize =CGSizeMake(ZF_LINE_WIDTH*titleArray.count, self.segmentHeight);
    for (int i = 0 ; i < self.titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.segmentWidth/4.0-ZF_LINE_WIDTH/2.0+self.segmentWidth/2.0*i, 0,ZF_LINE_WIDTH, self.segmentHeight-2);
        btn.tag = i+1;
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.titleSelectColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnIndexClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = self.titleFont;
        [self.bgScrollView addSubview:btn];
        [self.btnArray addObject:btn];
        if (self.defaultSelectIndex - 1 == i) {
            self.selectBtn = btn;
            btn.selected = YES;
            btn.transform = CGAffineTransformMakeScale(1*ZF_BASE_SCALE+1, 1*ZF_BASE_SCALE+1);
        }
    }
}
//segment 点击按钮事件
-(void)btnIndexClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(dySegment:didSelectIndex:)]) {
        [self.delegate dySegment:self didSelectIndex:btn.tag];
    }
    if (btn.tag == self.defaultSelectIndex) {
        return;
    }else{
        self.selectBtn.selected = NO;
        btn.selected = YES;
        self.selectBtn = btn;
        self.defaultSelectIndex = btn.tag;
    }
}
//视图偏移时，控件随着发生变化
-(void)dyDidScrollChangeTheTitleColorWithContentOfSet:(CGFloat)width{
    NSInteger leftIndex = width/ZFScreenW -1;
    if (leftIndex < 0) {
        leftIndex = 0;
    }
    NSInteger rightIndex    = leftIndex + 1;
    
    //获取左边按钮
    UIButton *leftBtn   = self.btnArray[leftIndex];
    UIButton *rightBtn;
    NSInteger count =  self.btnArray.count;
    if (rightIndex < count) {
        rightBtn = self.btnArray[rightIndex];
    }
    
    //计算右边按钮的偏移比 相对比
    CGFloat rightScale  = width/ZFScreenW;
    rightScale          = rightScale-leftIndex;
    
    //左边按钮的偏移比
    CGFloat leftScale   = 1-rightScale;
    
    //按钮发生相对应的形变
    leftBtn.transform   = CGAffineTransformMakeScale(leftScale*ZF_BASE_SCALE+1, leftScale*ZF_BASE_SCALE+1);
    rightBtn.transform  = CGAffineTransformMakeScale(rightScale*ZF_BASE_SCALE+1, rightScale*ZF_BASE_SCALE+1);
    
    //按钮文字颜色渐变
    CGFloat normalRed,normalGreen,normalBlue,normalAlpha;
    CGFloat selectRed,selectGreen,selectBlue,selectAlpha;
    
    //获取正常设置颜色
    [self.titleNormalColor getRed:&normalRed green:&normalGreen blue:&normalBlue alpha:&normalAlpha];
    [self.titleSelectColor getRed:&selectRed green:&selectGreen blue:&selectBlue alpha:&selectAlpha];
    
    //选中和未选中的色差
    CGFloat redDif      = selectRed - normalRed;
    CGFloat greenDif    = selectGreen - normalGreen;
    CGFloat blueDif     = selectBlue - normalBlue;
    CGFloat alphaDif    = selectAlpha - normalAlpha;
    
    leftBtn.titleLabel.textColor = [UIColor colorWithRed:leftScale * redDif + normalRed green:leftScale * greenDif + normalGreen blue:leftScale * blueDif + normalBlue alpha:leftScale * alphaDif+normalAlpha];
    rightBtn.titleLabel.textColor = [UIColor colorWithRed:rightScale * redDif + normalRed green:rightScale * greenDif + normalGreen blue:rightScale * blueDif + normalBlue alpha:rightScale * alphaDif+normalAlpha];
    
    //底部线的偏移
    CGRect frame    = self.bottomLine.frame;
    CGFloat lineDif = rightBtn.frame.origin.x-leftBtn.frame.origin.x;
    
    frame.origin.x  = rightScale*lineDif+leftBtn.frame.origin.x;
    CGFloat widthDif = rightBtn.frame.size.width-leftBtn.frame.size.width;
    if (widthDif != 0) {
        CGFloat leftSelectBgWidth = leftBtn.frame.size.width;
        frame.size.width = rightScale*widthDif + leftSelectBgWidth;
    }
    self.bottomLine.frame = frame;
    
}
@end
