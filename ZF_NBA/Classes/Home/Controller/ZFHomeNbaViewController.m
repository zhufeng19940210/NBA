
//
//  ZFHomeNbaViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/5.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import "ZFHomeNbaViewController.h"
#import "ZFHomeNbaHeaerView.h"
#import "ZFNetWorkCacheTool.h"
#import "ZFHomeNbaCell.h"
#import "ZFHomeModel.h"
#import "ZFLiveModel.h"
#import "ZFVideoViewController.h"
@interface ZFHomeNbaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *homeNbaTableView;
@property (nonatomic,strong)NSMutableArray *normalArray;
@property (nonatomic,strong)NSMutableArray *liveArray;
@property (nonatomic,strong)ZFHomeNbaHeaerView *headView;
@end
static NSString *const  homeNbaCellIdentity = @"HomeNbaCellIdentity";
@implementation ZFHomeNbaViewController
-(NSMutableArray *)normalArray{
    if (!_normalArray) {
        _normalArray = [NSMutableArray array];
    }
    return _normalArray;
}
-(NSMutableArray *)liveArray{
    if (!_liveArray) {
        _liveArray = [NSMutableArray array];
    }
    return _liveArray;
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
    [self.liveArray removeAllObjects];
    [[ZFNetWorkCacheTool ShareWorkTool]GETWithUrl:ZF_HOME_NBA_URL parameter:nil success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"responseObject:%@",responseObject);
        NSArray *norarray = responseObject[@"result"][@"list"][1][@"tr"];
        NSArray *livearray = responseObject[@"result"][@"list"][1][@"live"];
        for (NSDictionary *dict in norarray) {
            ZFHomeModel *model = [ZFHomeModel yy_modelWithJSON:dict];
            [self.normalArray addObject:model];
        }
        for (NSDictionary *dict in livearray) {
            ZFLiveModel *liveModel = [ZFLiveModel yy_modelWithJSON:dict];
            [self.liveArray addObject:liveModel];
        }
        //刷新界面
        [self.homeNbaTableView reloadData];
        [self.headView setModel:self.liveArray[0]];
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
    UINib *nib = [UINib nibWithNibName:@"ZFHomeNbaHeaerView" bundle:nil];
    ZFHomeNbaHeaerView *header = [nib instantiateWithOwner:nil options:nil][0];
    header.autoresizingMask = UIViewAutoresizingNone;
    self.homeNbaTableView.tableHeaderView = header;
    self.headView = header;
    if (self.liveArray.count!=0) {
        [self.headView setModel:self.liveArray[0]];
    }
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
    int tag = (int)indexPath.row;
    cell.jishuBtn.tag = tag;
    cell.videoBtn.tag = tag;
    [cell.jishuBtn addTarget:self action:@selector(JuSuTongJiBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.videoBtn addTarget:self action:@selector(ViodeoBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZFHomeModel *model = self.normalArray[tag];
    cell.model = model;
    return cell;
}
#pragma mark - 技术统计的事件
-(void)JuSuTongJiBtn:(UIButton *)button{
    int tag = (int)button.tag;
    ZFHomeModel *model = self.normalArray[tag];
    ZFVideoViewController *videoVc = [[ZFVideoViewController alloc]init];
    videoVc.urlStr = model.link2url;
    videoVc.titleStr = @"技术统计";
    [self.navigationController pushViewController:videoVc animated:YES];
}
#pragma mark --视频集锦
-(void)ViodeoBtn:(UIButton *)button{
    int tag = (int)button.tag;
    ZFHomeModel *model = self.normalArray[tag];
    ZFVideoViewController *videoVc = [[ZFVideoViewController alloc]init];
    videoVc.urlStr = model.link1url;
    videoVc.titleStr = @"视频集锦";
    [self.navigationController pushViewController:videoVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
