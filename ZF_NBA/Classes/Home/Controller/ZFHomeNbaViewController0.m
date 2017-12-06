
//
//  ZFHomeNbaViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/5.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import "ZFHomeNbaViewController0.h"
#import "ZFHomeNbaHeaerView.h"
#import "ZFNetWorkCacheTool.h"
#import "ZFHomeNbaCell.h"
#import "ZFHomeModel.h"
#import "ZFLiveModel.h"
@interface ZFHomeNbaViewController0 ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *homeNbaTableView;
@property (nonatomic,strong)NSMutableArray *normalArray;
@end
static NSString *const  homeNbaCellIdentity = @"HomeNbaCellIdentity";
@implementation ZFHomeNbaViewController0
-(NSMutableArray *)normalArray{
    if (!_normalArray) {
        _normalArray = [NSMutableArray array];
    }
    return _normalArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //请求数据了
    [self setupRefreshData];
    //创建tableView
    [self setupTableView];
}
-(void)setupRefreshData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.normalArray removeAllObjects];
    [[ZFNetWorkCacheTool ShareWorkTool]GETCacheWithUrl:ZF_HOME_NBA_URL paramter:nil success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"responseObject:%@",responseObject);
        NSArray *norarray = responseObject[@"result"][@"list"][0][@"tr"];
        for (NSDictionary *dict in norarray) {
            ZFHomeModel *model = [ZFHomeModel yy_modelWithJSON:dict];
            [self.normalArray addObject:model];
        }
        //刷新界面
        [self.homeNbaTableView reloadData];
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(void)setupTableView{
    self.homeNbaTableView.delegate = self;
    self.homeNbaTableView.dataSource = self;
    self.homeNbaTableView.rowHeight = 60;
    self.homeNbaTableView.showsVerticalScrollIndicator = NO;
    self.homeNbaTableView.showsHorizontalScrollIndicator = NO;
    //注册cell
    [self.homeNbaTableView registerNib:[UINib nibWithNibName:@"ZFHomeNbaCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:homeNbaCellIdentity];
}

#pragma mark -uitableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.normalArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZFHomeNbaCell *cell = [tableView dequeueReusableCellWithIdentifier:homeNbaCellIdentity];
    if (cell== nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZFHomeNbaCell" owner:nil options:nil]lastObject];
    }
    ZFHomeModel *model = self.normalArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
