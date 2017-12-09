//
//  ZFFootSubViewController4.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFFootSubViewController4.h"
#import "ZFFootSubModel4.h"
#import "ZFFootsubTableViewCell4.h"
#import "ZFVideoViewController.h"
@interface ZFFootSubViewController4 () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *footTableView;
@property (nonatomic,strong)NSMutableArray *array;
@end
static NSString *const footSubCellIdentity = @"FootCellIdentity";
@implementation ZFFootSubViewController4
-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
-(void)setDataArray:(NSMutableArray *)dataArray{
    [self.array addObjectsFromArray:dataArray];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}
-(void)setupTableView{
    self.footTableView.delegate = self;
    self.footTableView.dataSource = self;
    self.footTableView.showsVerticalScrollIndicator = NO;
    self.footTableView.showsHorizontalScrollIndicator = NO;
    self.footTableView.rowHeight = 60;
    //注册cell
    [self.footTableView registerNib:[UINib nibWithNibName:@"ZFFootsubTableViewCell4" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:footSubCellIdentity];
}
#pragma makr - uitableViewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"4444的数量:%lu",(unsigned long)self.array.count);
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZFFootsubTableViewCell4 *cell = [tableView dequeueReusableCellWithIdentifier:footSubCellIdentity];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZFFootsubTableViewCell4" owner:nil options:nil]lastObject];
    }
    ZFFootSubModel4 *model = self.array[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZFFootSubModel4 *model = self.array[indexPath.row];
    ZFVideoViewController *videoVc = [[ZFVideoViewController alloc]init];
    videoVc.titleStr = [NSString stringWithFormat:@"%@--%@",model.c3,model.c2];
    videoVc.urlStr = model.c2L;
    [self.navigationController pushViewController:videoVc animated:YES];
}
@end
