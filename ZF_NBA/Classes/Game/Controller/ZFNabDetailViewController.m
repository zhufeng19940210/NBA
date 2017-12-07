//
//  ZFNabDetailViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import "ZFNabDetailViewController.h"
#import "ZFNetWorkCacheTool.h"
#import "ZFNbaDetail.h"
#import "ZFNbaDetailTableViewCell.h"
#import "ZFDetailHeaderView.h"
@interface ZFNabDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *nbaDetailTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end
static NSString *const detailCellidentity = @"detailCellIdentity";
@implementation ZFNabDetailViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.name;
    [self setupData];
    [self setupTableView];
}
-(void)setupData{
    NSString *urlStr = [NSString stringWithFormat:@"http://china.nba.com/static/data/team/schedule_%@.json",self.model.code];
    NSLog(@"urlStr:%@",urlStr);
    [self.dataArray removeAllObjects];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ZFNetWorkCacheTool ShareWorkTool]GETWithUrl:urlStr parameter:nil success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"responseObject:%@",responseObject);
        NSArray *array = responseObject[@"payload"][@"monthGroups"];
        for (NSDictionary *dict in array) {
            NSArray *tempArray = dict[@"games"];
            for (NSDictionary *dict2 in tempArray) {
                ZFNbaDetail *detail = [[ZFNbaDetail alloc]init];
                detail.arenaName = dict2[@"profile"][@"arenaName"];
                detail.utcMillis = dict2[@"profile"][@"utcMillis"];
                detail.Homecity = dict2[@"homeTeam"][@"profile"][@"city"];
                detail.HomedisplayAbbr = dict2[@"homeTeam"][@"profile"][@"displayAbbr"];
                detail.AwayCity = dict2[@"awayTeam"][@"profile"][@"city"];
                detail.AwaydisplayAbbr = dict2[@"awayTeam"][@"profile"][@"displayAbbr"];
                [self.dataArray addObject:detail];
            }
        }
        [self.nbaDetailTableView reloadData];
    } failure:^(NSString *error) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }];
}
-(void)setupTableView{
    self.nbaDetailTableView.delegate = self;
    self.nbaDetailTableView.dataSource = self;
    self.nbaDetailTableView.showsVerticalScrollIndicator = NO;
    self.nbaDetailTableView.showsHorizontalScrollIndicator = NO;
    self.nbaDetailTableView.rowHeight = 80;
    UINib *nib = [UINib nibWithNibName:@"ZFDetailHeaderView" bundle:nil];
    ZFDetailHeaderView *header = [nib instantiateWithOwner:nil options:nil][0];
    header.autoresizingMask = UIViewAutoresizingNone;
    self.nbaDetailTableView.tableHeaderView = header;
    //注册cell
    [self.nbaDetailTableView registerNib:[UINib nibWithNibName:@"ZFNbaDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:detailCellidentity];
}
#pragma mark - uitableViewDelgate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"数量:%lu",(unsigned long)self.dataArray.count);
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZFNbaDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellidentity];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZFNbaDetailTableViewCell" owner:nil options:nil]lastObject];
    }
    ZFNbaDetail *detail = self.dataArray[indexPath.row];
    cell.detail = detail;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
