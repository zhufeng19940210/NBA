//
//  ZFPlayerDetailViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/9.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import "ZFPlayerDetailViewController.h"
#import "BTSpiderPlotterView.h"
@interface ZFPlayerDetailViewController ()
@property (nonatomic,strong)BTSpiderPlotterView *spiderPlotView;
@end
@implementation ZFPlayerDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titleStr;
    BTSpiderPlotterView *spiderPlotView = [[BTSpiderPlotterView alloc]initWithFrame:CGRectMake(0, 0, 300, 300) valueDictionary:self.dictionary];
    spiderPlotView.center = self.view.center;
    spiderPlotView.plotColor = [UIColor colorWithRed:.0 green:1 blue:.0 alpha:.5];
    [self.view addSubview:spiderPlotView];
}
@end
