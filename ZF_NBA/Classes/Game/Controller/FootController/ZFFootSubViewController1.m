//
//  ZFFootSubViewController1.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFFootSubViewController1.h"
#import "ZFFootSubModel.h"
#import "ZFFootSubTableViewCell.h"
@interface ZFFootSubViewController1 ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *footTablevView;
@property (nonatomic,strong)NSMutableArray *myArray;
@end
static NSString *const footSubCell = @"footsubCellIdentity";
@implementation ZFFootSubViewController1
-(NSMutableArray *)myArray{
    if (!_myArray) {
        _myArray = [NSMutableArray array];
    }
    return _myArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}
-(void)setDataArray:(NSMutableArray *)dataArray{
    [self.myArray addObjectsFromArray:dataArray];
}
-(void)setupTableView{
    self.footTablevView.delegate = self;
    self.footTablevView.dataSource = self;
    self.footTablevView.rowHeight = 60;
    self.footTablevView.showsVerticalScrollIndicator = NO;
    self.footTablevView.showsHorizontalScrollIndicator = NO;
    //注册cell
    [self.footTablevView registerNib:[UINib nibWithNibName:@"ZFFootSubTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:footSubCell];
}
#pragma makr - uitableViewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZFFootSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:footSubCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZFFootSubTableViewCell" owner:nil options:nil]lastObject];
    }
    ZFFootSubModel *model = self.myArray[indexPath.row];
    cell.footModel = model;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
