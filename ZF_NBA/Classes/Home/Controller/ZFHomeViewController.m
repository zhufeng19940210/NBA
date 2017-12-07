//
//  ZFHomeViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/4.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFHomeViewController.h"
#import "SGPageTitleViewConfigure.h"
#import "SGPageTitleView.h"
#import "SGPageContentView.h"
#import "SGPageContentScrollView.h"
#import "ZFHomeNbaViewController0.h"
#import "ZFHomeNbaViewController.h"
#import "ZFHomeNbaViewController2.h"
@interface ZFHomeViewController () <SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic,strong)ZFHomeNbaViewController0 *homeNbaVc0;
@property (nonatomic,strong)ZFHomeNbaViewController  *homeNbaVc;
@property (nonatomic,strong)ZFHomeNbaViewController2 *homeNbaVc2;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@end
@implementation ZFHomeViewController
-(ZFHomeNbaViewController0 *)homeNbaVc0{
    if (!_homeNbaVc0) {
        _homeNbaVc0 = [[ZFHomeNbaViewController0 alloc]init];
    }
    return _homeNbaVc0;
}
-(ZFHomeNbaViewController *)homeNbaVc{
    if (!_homeNbaVc) {
        _homeNbaVc = [[ZFHomeNbaViewController alloc]init];
    }
    return _homeNbaVc;
}
-(ZFHomeNbaViewController2 *)homeNbaVc2{
    if (!_homeNbaVc2) {
        _homeNbaVc2 = [[ZFHomeNbaViewController2 alloc]init];
    }
    return _homeNbaVc2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNavigationBar];
}
/*
 https://github.com/kingsic/SGPagingView
 */
-(void)configNavigationBar{
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    NSArray *titleArr = @[@"昨天",@"今天",@"后天"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorScrollStyle =  SGIndicatorScrollStyleEnd;
    configure.titleFont = [UIFont systemFontOfSize:18];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(ZFScreenW/2-120, 25, 200, 44) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView.backgroundColor = [UIColor clearColor];
    self.pageTitleView.isTitleGradientEffect = NO;
    self.pageTitleView.selectedIndex = 1;
    self.pageTitleView.isNeedBounces = NO;
    NSArray *childArr = @[self.homeNbaVc0,self.homeNbaVc,self.homeNbaVc2];
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
@end
