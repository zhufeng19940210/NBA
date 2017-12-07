//
//  ZFFootViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/4.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFFootViewController.h"
#import "ZFGameFootTableViewCell.h"
#import "ZFFootModel.h"
#import "ZFFootDetailViewController.h"
@interface ZFFootViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *footTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end
static NSString *const footCellIdentity = @"FootCellIdentity";
@implementation ZFFootViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupData];
    [self setupTableView];
}
-(void)setupData{
    [self.dataArray removeAllObjects];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"foot" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *arry = dic[@"result"];
    for (NSDictionary *dict  in arry) {
        ZFFootModel *model = [ZFFootModel yy_modelWithJSON:dict];
        [self.dataArray addObject:model];
    }
}
-(void)setupTableView{
    self.footTableView.delegate = self;
    self.footTableView.dataSource = self;
    self.footTableView.rowHeight =  60;
    self.footTableView.showsVerticalScrollIndicator = NO;
    self.footTableView.showsHorizontalScrollIndicator = NO;
    //注册cell
    [self.footTableView registerNib:[UINib nibWithNibName:@"ZFGameFootTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:footCellIdentity];
}
#pragma mark - uitableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZFGameFootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:footCellIdentity];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZFGameFootTableViewCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZFFootModel *model = self.dataArray[indexPath.row];
    cell.footModel = model;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZFFootModel *model = self.dataArray[indexPath.row];
    ZFFootDetailViewController *detailVc = [[ZFFootDetailViewController alloc]init];
    detailVc.model = model;
    [self.navigationController pushViewController:detailVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
