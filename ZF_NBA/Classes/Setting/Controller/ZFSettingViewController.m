//
//  ZFSettingViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/4.
//  Copyright © 2017年 zhufeng. All rights reserved.
#import "ZFSettingViewController.h"
#import "ZFVideoViewController.h"
#import "ZFPlyerViewController.h"
#import "ZFSettingTableViewCell.h"
@interface ZFSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *setttingTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end
static NSString *const identity = @"SettingCellIdentity";
@implementation ZFSettingViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"NBA球队排名",@"篮球明星",@"足球明星",@"球队介绍", nil];
    }
    return _dataArray;
}
-(UITableView *)setttingTableView{
    if (!_setttingTableView) {
        _setttingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenW, ZFScreenH) style:UITableViewStylePlain];
        _setttingTableView.delegate = self;
        _setttingTableView.dataSource = self;
        _setttingTableView.showsVerticalScrollIndicator = NO;
        _setttingTableView.showsHorizontalScrollIndicator = NO;
        _setttingTableView.rowHeight = 50;
        _setttingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //注册cell
        [_setttingTableView registerClass:[ZFSettingTableViewCell class] forCellReuseIdentifier:identity];
    }
    return _setttingTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.setttingTableView];
}
#pragma mark -uitableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZFSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    cell.myTittleLabel.text = self.dataArray[indexPath.row];
    return cell;
}
#pragma mark --点击了table的东西了
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0 || indexPath.row == 3) {
        ZFVideoViewController *videoVc = [[ZFVideoViewController alloc]init];
        videoVc.titleStr = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:videoVc animated:YES];
    }else if (indexPath.row == 1 || indexPath.row == 2){
        ZFPlyerViewController *playerVc = [[ZFPlyerViewController alloc]init];
        playerVc.titleStr = self.dataArray [indexPath.row];
        [self.navigationController pushViewController:playerVc animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
