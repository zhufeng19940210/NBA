//
//  ZFFootSubViewController2.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFFootSubViewController2.h"
#import "ZFFootSubModel.h"
#import "ZFFootSubTableViewCell.h"
@interface ZFFootSubViewController2 ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *footTableView;
@property (nonatomic,strong)NSMutableArray *array;
@end
static NSString *const footSubCell = @"footsubCellIdentity";
@implementation ZFFootSubViewController2
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
    [self.footTableView registerNib:[UINib nibWithNibName:@"ZFFootSubTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:footSubCell];
}
#pragma makr - uitableViewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZFFootSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:footSubCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZFFootSubTableViewCell" owner:nil options:nil]lastObject];
    }
    ZFFootSubModel *model = self.array[indexPath.row];
    cell.footModel = model;
    return cell;
}
@end
