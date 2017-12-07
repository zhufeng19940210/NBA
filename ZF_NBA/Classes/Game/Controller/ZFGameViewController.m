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
#import "SGPageTitleViewConfigure.h"
#import "SGPageTitleView.h"
#import "SGPageContentView.h"
#import "SGPageContentScrollView.h"
@interface ZFGameViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic,strong)ZFNbaViewController *nabVc;
@property (nonatomic,strong)ZFFootViewController*footVc;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //配置界面
    [self configNavigationBar];
}
-(void)configNavigationBar{
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    NSArray *titleArr = @[@"篮球",@"足球"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorScrollStyle = SGIndicatorScrollStyleHalf;
    configure.titleFont = [UIFont systemFontOfSize:18];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(ZFScreenW/2-120, 25, 200, 44) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView.backgroundColor = [UIColor clearColor];
    self.pageTitleView.isTitleGradientEffect = NO;
    self.pageTitleView.selectedIndex = 0;
    self.pageTitleView.isNeedBounces = NO;
    NSArray *childArr = @[self.nabVc,self.footVc];
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 0, ZFScreenW, ZFScreenH - 105) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:self.pageContentView];
    self.navigationItem.titleView = self.pageTitleView;
}
#pragma mark -- SGPageContentViewDelegate
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}
#pragma mark SGPageTitleViewDelegate
- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
