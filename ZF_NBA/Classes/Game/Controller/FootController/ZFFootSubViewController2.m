//
//  ZFFootSubViewController2.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import "ZFFootSubViewController2.h"
#import "ZFFootSubModel.h"
@interface ZFFootSubViewController2 ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *footTableView;
@property (nonatomic,strong)NSMutableArray *array;
@end
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
}
#pragma makr - uitableViewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    ZFFootSubModel *model = self.array[indexPath.row];
    cell.textLabel.text = model.c4T1;
    return cell;
}
@end
