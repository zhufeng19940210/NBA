//
//  ZFNbaViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/4.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFNbaViewController.h"
#import "ZFNetWorkCacheTool.h"
#import "ZFTeamModel.h"
#import "ZFGameNbaTableViewCell.h"
#import "ZFNabDetailViewController.h"
@interface ZFNbaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *nbaTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSDictionary *logoDict;
@end
static NSString *const gameNbaCell = @"gameNbaCell";
@implementation ZFNbaViewController
-(NSDictionary *)logoDict{
    if (!_logoDict) {
        _logoDict = [NSDictionary dictionary];
    }
    return _logoDict;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray  = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //请求数据了
    [self setupData];
    [self setupTableView];
}
-(void)setupData{
    [[ZFNetWorkCacheTool ShareWorkTool]GETWithUrl:@"http://china.nba.com/static/data/league/conferenceteamlist.json" parameter:nil success:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        NSArray *listGroups = responseObject[@"payload"][@"listGroups"];
        for (NSDictionary *dict in listGroups) {
            NSMutableArray *tempArray = [NSMutableArray array];
            NSArray *teamsArray = dict[@"teams"];
            for (NSDictionary *dict in teamsArray) {
                NSDictionary *dict2 = dict[@"profile"];
                ZFTeamModel *model = [ZFTeamModel yy_modelWithJSON:dict2];
                [tempArray addObject:model];
            }
            [self.dataArray addObject:tempArray];
        }
        [self.nbaTableView  reloadData];
    } failure:^(NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(void)setupTableView{
    self.nbaTableView.delegate = self;
    self.nbaTableView.dataSource = self;
    self.nbaTableView.rowHeight = 60;
    self.nbaTableView.showsVerticalScrollIndicator = NO;
    self.nbaTableView.showsHorizontalScrollIndicator = NO;
    //注册cell
    [self.nbaTableView registerNib:[UINib nibWithNibName:@"ZFGameNbaTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:gameNbaCell];
}
#pragma mark - uitableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"分区的个数:%lu",(unsigned long)self.dataArray.count);
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    NSLog(@"分区的数量:%lu",array.count);
    return array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZFGameNbaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:gameNbaCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZFGameNbaTableViewCell" owner:nil options:nil]lastObject];
    }
    NSArray *teamArray = self.dataArray[indexPath.section];
    ZFTeamModel *model = teamArray[indexPath.row];
    cell.teamModel = model;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *teamsArray = self.dataArray[section];
    ZFTeamModel *model = teamsArray[0];
    return model.displayConference;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *teamArray = self.dataArray[indexPath.section];
    ZFTeamModel *model = teamArray[indexPath.row];
    ZFNabDetailViewController *detailVc = [[ZFNabDetailViewController alloc]init];
    detailVc.model = model;
    [self.navigationController pushViewController:detailVc animated:YES];
}
@end
