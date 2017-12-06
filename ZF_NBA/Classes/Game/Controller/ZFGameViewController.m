//
//  ZFGameViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/4.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFGameViewController.h"
#import "ZFNbaViewController.h"
#import "ZFFootViewController.h"
#import "ZFSegmentView.h"
@interface ZFGameViewController () <ZFSegmentViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)ZFSegmentView *segmentView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)ZFNbaViewController *nabVc;
@property (nonatomic,strong)ZFFootViewController*footVc;
@end
@implementation ZFGameViewController

-(ZFNbaViewController *)nabVc{
    if (!_nabVc) {
        _nabVc = [[ZFNbaViewController alloc]init];
    }
    return _nabVc;
}
-(ZFFootViewController *)footVc{
    if (!_footVc) {
        _footVc = [[ZFFootViewController alloc]init];
    }
    return _footVc;
}
-(ZFSegmentView *)segmentView{
    if (!_segmentView) {
        _segmentView = [[ZFSegmentView alloc]initWithFrame:CGRectMake(ZFScreenW/2-120, 25, 200, 44)];
        _segmentView.delegate               = self;
        _segmentView.backgroundColor        = [UIColor clearColor];
        _segmentView.titleNormalColor       = UIColorFromRGB(0xffffff, 0.5);
        _segmentView.titleSelectColor       = UIColorFromRGB(0xffffff, 0.9);
        _segmentView.titleFont              = [UIFont systemFontOfSize:15];
        _segmentView.titleArray             = @[@"篮球",@"足球"];
    }
    return _segmentView;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
          _scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenW, ZFScreenH)];
          _scrollView.delegate = self;
          _scrollView.showsVerticalScrollIndicator = NO;
          _scrollView.showsHorizontalScrollIndicator = NO;
          _scrollView.contentSize = CGSizeMake(ZFScreenW * 2, ZFScreenH);
          _scrollView.pagingEnabled = YES;
          _scrollView.bounces = NO;
    }
    return _scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //配置界面
    [self configNavigationBar];
    //初始化界面
    [self initWithScollView];
}
-(void)configNavigationBar{
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    //[ self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x000000, 1.0)];//纯粹为了界面好看
    self.navigationItem.titleView = self.segmentView;
}
-(void)initWithScollView{
    [self.view addSubview:self.scrollView];
    [self addChildViewController:self.nabVc];
    [self addChildViewController:self.footVc];
    self.nabVc.view.frame = CGRectMake(0, 0, ZFScreenW, ZFScreenH);
    self.footVc.view.frame = CGRectMake(ZFScreenW, 0, ZFScreenW, ZFScreenH);
    [self.scrollView addSubview:self.nabVc.view];
    [self.scrollView addSubview:self.footVc.view];
}
#pragma mark uiscrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_segmentView dyDidScrollChangeTheTitleColorWithContentOfSet:scrollView.contentOffset.x];
}
#pragma mark - ZFSegmentViewDelegate
-(void)dySegment:(ZFSegmentView *)segment didSelectIndex:(NSInteger)index{
    NSString *notiStr;
    if (index == 1) {
        notiStr = @"1";
    }else {
        notiStr = @"2";
    }
    self.scrollView.contentOffset = CGPointMake(ZFScreenW *(index- 1), 0);
    //发送通知出去了
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MainViewScrollDidScroll" object:notiStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
