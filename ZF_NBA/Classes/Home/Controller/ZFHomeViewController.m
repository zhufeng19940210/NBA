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
#import "ZFNetWorkCacheTool.h"
#import "ZFHomeModel.h"
#import "ZFLiveModel.h"
@interface ZFHomeViewController () <SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic,strong)ZFHomeNbaViewController0 *homeNbaVc0;
@property (nonatomic,strong)ZFHomeNbaViewController  *homeNbaVc;
@property (nonatomic,strong)ZFHomeNbaViewController2 *homeNbaVc2;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *todayArray;
@property (nonatomic,strong)NSMutableArray *beforeArray;
@property (nonatomic,strong)NSMutableArray *nextArray;
@property (nonatomic,strong)NSMutableArray *liveArray;
@end
@implementation ZFHomeViewController
-(NSMutableArray *)liveArray{
    if (!_liveArray) {
        _liveArray = [NSMutableArray array];
    }
    return _liveArray;
}
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
-(NSMutableArray *)todayArray{
    if (!_todayArray) {
        _todayArray = [NSMutableArray array];
    }
    return _todayArray;
}
-(NSMutableArray *)beforeArray{
    if (!_beforeArray) {
        _beforeArray = [NSMutableArray array];
    }
    return _beforeArray;
}
-(NSMutableArray *)nextArray{
    if (!_nextArray) {
        _nextArray = [NSMutableArray array];
    }
    return _nextArray;
}
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
    //这里是去请求数据了
    [self setupData];
    //[self configNavigationBar];
}
//这里是请求数据了
-(void)setupData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.titleArray removeAllObjects];
    [self.todayArray removeAllObjects];
    [self.beforeArray removeAllObjects];
    [self.nextArray removeAllObjects];
    [[ZFNetWorkCacheTool ShareWorkTool]GETWithUrl:ZF_HOME_NBA_URL parameter:nil success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"responseObject:%@",responseObject);
        NSString *title = responseObject[@"result"][@"list"][0][@"title"];
        NSString *title2 = responseObject[@"result"][@"list"][1][@"title"];
        NSString *title3 = responseObject[@"result"][@"list"][2][@"title"];
        [self.titleArray addObject:title];
        [self.titleArray addObject:title2];
        [self.titleArray addObject:title3];
        NSArray *norarray = responseObject[@"result"][@"list"][0][@"tr"];
        for (NSDictionary *dict in norarray) {
            ZFHomeModel *model = [ZFHomeModel yy_modelWithJSON:dict];
            [self.beforeArray addObject:model];
        }
        NSArray *norarray2 = responseObject[@"result"][@"list"][1][@"tr"];
        for (NSDictionary *dict in norarray2 ) {
            ZFHomeModel *model = [ZFHomeModel yy_modelWithJSON:dict];
            [self.todayArray addObject:model];
        }
        NSArray *livearray = responseObject[@"result"][@"list"][1][@"live"];
        for (NSDictionary *dict in livearray) {
            ZFLiveModel *liveModel = [ZFLiveModel yy_modelWithJSON:dict];
            [self.liveArray addObject:liveModel];
        }
        NSArray *norarray3 = responseObject[@"result"][@"list"][2][@"tr"];
        for (NSDictionary *dict in norarray3) {
            ZFHomeModel *model = [ZFHomeModel yy_modelWithJSON:dict];
            [self.nextArray addObject:model];
        }
        [self configNavigationBar];
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
/*
 https://github.com/kingsic/SGPagingView
 */
-(void)configNavigationBar{
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorScrollStyle =  SGIndicatorScrollStyleEnd;
    configure.titleFont = [UIFont systemFontOfSize:18];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 25, ZFScreenW, 44) delegate:self titleNames:self.titleArray configure:configure];
    self.pageTitleView.backgroundColor = [UIColor clearColor];
    self.pageTitleView.isTitleGradientEffect = NO;
    self.pageTitleView.selectedIndex = 1;
    self.pageTitleView.isNeedBounces = NO;
    self.homeNbaVc.dataArray = self.todayArray;
    self.homeNbaVc.liveArray2 = self.liveArray;
    self.homeNbaVc0.dataArray = self.beforeArray;
    self.homeNbaVc2.dataArray = self.nextArray;
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
