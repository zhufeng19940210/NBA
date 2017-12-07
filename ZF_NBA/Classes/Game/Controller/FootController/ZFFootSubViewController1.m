//
//  ZFFootSubViewController1.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import "ZFFootSubViewController1.h"
#import "ZFFootSubModel.h"
@interface ZFFootSubViewController1 ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *footTablevView;
@property (nonatomic,strong)NSMutableArray *myArray;
@end
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
    self.footTablevView.showsVerticalScrollIndicator = NO;
    self.footTablevView.showsHorizontalScrollIndicator = NO;
}
#pragma makr - uitableViewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    ZFFootSubModel *model = self.myArray[indexPath.row];
    cell.textLabel.text = model.c4T1;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
