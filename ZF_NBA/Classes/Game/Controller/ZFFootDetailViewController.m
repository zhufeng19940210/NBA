//
//  ZFFootDetailViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFFootDetailViewController.h"
#import "ZFFootSubViewController1.h"
#import "ZFFootSubViewController2.h"
#import "ZFFootSubViewController4.h"
#import "SGPageTitleViewConfigure.h"
#import "SGPageTitleView.h"
#import "SGPageContentView.h"
#import "SGPageContentScrollView.h"
#import "ZFNetWorkCacheTool.h"
#import "ZFFootSubModel.h"
#import "ZFFootSubModel4.h"
@interface ZFFootDetailViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic,strong)ZFFootSubViewController1 *foot1Vc;
@property (nonatomic,strong)ZFFootSubViewController2 *foot2Vc;
@property (nonatomic,strong)ZFFootSubViewController4 *foot4vc;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *game1Array;
@property (nonatomic,strong)NSMutableArray *game2Array;
@property (nonatomic,strong)NSMutableArray *game4Array;
@end
@implementation ZFFootDetailViewController
-(ZFFootSubViewController1 *)foot1Vc{
    if (!_foot1Vc) {
        _foot1Vc = [[ZFFootSubViewController1 alloc]init];
    }
    return _foot1Vc;
}
-(ZFFootSubViewController2 *)foot2Vc{
    if (!_foot2Vc) {
        _foot2Vc = [[ZFFootSubViewController2 alloc]init];
    }
    return _foot2Vc;
}
-(ZFFootSubViewController4 *)foot4vc{
    if (!_foot4vc) {
        _foot4vc = [[ZFFootSubViewController4 alloc]init];
    }
    return _foot4vc;
}
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
-(NSMutableArray *)game1Array{
    if (!_game1Array) {
        _game1Array = [NSMutableArray array];
    }
    return _game1Array;
}
-(NSMutableArray *)game2Array{
    if (!_game2Array) {
        _game2Array = [NSMutableArray array];
    }
    return _game2Array;
}
-(NSMutableArray *)game4Array{
    if (!_game4Array) {
        _game4Array = [NSMutableArray array];
    }
    return _game4Array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
}
-(void)setupData{
    NSString *urlStr = [NSString stringWithFormat:@"http://api.avatardata.cn/Football/Query?key=755afbbee32b4e39a53d658540931876&league=%@",self.model.name];
    NSLog(@"urlStr:%@",urlStr);
    [self.titleArray removeAllObjects];
    [self.game1Array removeAllObjects];
    [self.game2Array removeAllObjects];
    [self.game4Array removeAllObjects];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ZFNetWorkCacheTool ShareWorkTool]GETWithUrl:urlStr parameter:nil success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"responseObject:%@",responseObject);
        NSDictionary *dict = responseObject[@"result"][@"tabs"];
        NSString *name1 = dict[@"saicheng1"];
        NSString *name2 = dict[@"saicheng2"];
        NSString *name4 = dict[@"sheshoubang"];
        [self.titleArray addObject:name1];
        [self.titleArray addObject:name2];
        [self.titleArray addObject:name4];
        NSLog(@"dict:%@",dict);
        if (responseObject[@"result"][@"views"][@"saicheng1"] !=nil) {
            NSArray * game1Array=responseObject[@"result"][@"views"][@"saicheng1"];
                for (NSDictionary *dict2 in game1Array) {
                    ZFFootSubModel *subModel = [ZFFootSubModel yy_modelWithJSON:dict2];
                    [self.game1Array addObject:subModel];
                }
        }
        if (responseObject[@"result"][@"views"][@"saicheng2"] != nil) {
            NSArray *game2Array  = responseObject[@"result"][@"views"][@"saicheng2"];
                for (NSDictionary *dict2 in game2Array) {
                    ZFFootSubModel *subModel = [ZFFootSubModel yy_modelWithJSON:dict2];
                    [self.game2Array addObject:subModel];
                }
        }
        if (responseObject[@"result"][@"views"][@"sheshoubang"] !=nil) {
             NSArray *game4Array = responseObject[@"result"][@"views"][@"sheshoubang"];
                for (NSDictionary *dict2 in game4Array) {
                    ZFFootSubModel4 *subModel4 = [ZFFootSubModel4 yy_modelWithJSON:dict2];
                    [self.game4Array addObject:subModel4];
                }
        }
        [self setupPageView];
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (void)setupPageView {
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorScrollStyle = SGIndicatorScrollStyleHalf;
    configure.titleFont = [UIFont systemFontOfSize:18];
    configure.titleColor = [UIColor grayColor];
    configure.titleSelectedColor = [UIColor redColor];
    configure.indicatorColor = [UIColor redColor];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(ZFScreenW/2-150, 0, 300, 44) delegate:self titleNames:(NSArray *)self.titleArray configure:configure];
    _pageTitleView.backgroundColor = [UIColor clearColor];
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.selectedIndex = 0;
    _pageTitleView.isNeedBounces = NO;
    [self.view addSubview:_pageTitleView];
    NSLog(@"self.game1Array:%lu,self.game2Array:%d,self.game4Array:%d",(unsigned long)self.game1Array.count,self.game2Array.count,self.game4Array.count);
    self.foot1Vc.dataArray = self.game1Array;
    self.foot2Vc.dataArray = self.game2Array;
    self.foot4vc.dataArray = self.game4Array;
    NSArray *childArr = @[self.foot1Vc,self.foot2Vc,self.foot4vc];
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame)-1, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];

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
