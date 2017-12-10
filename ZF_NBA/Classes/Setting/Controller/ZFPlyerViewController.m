//
//  ZFPlyerViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/9.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFPlyerViewController.h"
#import "ZFSettingTableViewCell.h"
#import "ZFPlayerDetailViewController.h"
@interface ZFPlyerViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *playerTableView;
@property (nonatomic,strong)NSMutableArray *nbaArray;
@property (nonatomic,strong)NSMutableArray *footArray;
@property (nonatomic,strong)NSMutableArray *numberArray;
@end
static NSString *const  playIdentity = @"playerCell";
@implementation ZFPlyerViewController
-(NSMutableArray *)nbaArray{
    if (!_nbaArray) {
        _nbaArray = [NSMutableArray arrayWithObjects:@"斯蒂芬-库里",@"克里斯-保罗",@"勒布朗-詹姆斯",@"威斯布鲁克",@"凯文-特兰特",nil];
    }
    return _nbaArray;
}
//C罗、梅西、内马尔、苏亚雷斯、贝尔
-(NSMutableArray *)footArray{
    if (!_footArray) {
        _footArray = [NSMutableArray arrayWithObjects:@"C罗",@"梅西",@"内马尔",@"苏亚雷斯",@"贝尔", nil];
    }
    return _footArray;
}
-(NSMutableArray *)numberArray{
    if (!_numberArray) {
        _numberArray = [NSMutableArray array];
    }
    return _numberArray;
}

-(UITableView *)playerTableView{
    if (!_playerTableView) {
        _playerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenW, ZFScreenH) style:UITableViewStylePlain];
        _playerTableView.delegate = self;
        _playerTableView.dataSource = self;
        _playerTableView.rowHeight = 50;
        _playerTableView.showsVerticalScrollIndicator = NO;
        _playerTableView.showsHorizontalScrollIndicator = NO;
        _playerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //注册cell
        [_playerTableView registerClass:[ZFSettingTableViewCell class] forCellReuseIdentifier:playIdentity];
    }
    return _playerTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titleStr;
    [self setupData];
    [self setupTableView];
}
-(void)setupData{
    if ([self.titleStr isEqualToString:@"篮球明星"]) {
        [self.numberArray removeAllObjects];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"NbaPlayer" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic:%@",dic[@"result"]);
        NSArray *array = dic[@"result"];
        for (NSDictionary *dict in array) {
            [self.numberArray addObject:dict];
        }
    }else{
        
    }
}
-(void)setupTableView{
    [self.view addSubview:self.playerTableView];
}
#pragma mark -uitableVeiwDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.titleStr isEqualToString:@"篮球明星"]) {
        return self.nbaArray.count;
    }else{
        return self.footArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZFSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:playIdentity];
    if ([self.titleStr isEqualToString:@"篮球明星"]) {
        cell.myTittleLabel.text = self.nbaArray[indexPath.row];
    }else{
        cell.myTittleLabel.text = self.footArray[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZFPlayerDetailViewController *detailVc = [[ZFPlayerDetailViewController alloc]init];
    detailVc.titleStr = self.nbaArray[indexPath.row];
    NSDictionary *dict = self.numberArray[indexPath.row];
    NSLog(@"dict:%@",dict);
    detailVc.dictionary = self.numberArray[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
