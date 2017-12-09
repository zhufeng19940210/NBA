//
//  ZFSettingViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/4.
//  Copyright © 2017年 zhufeng. All rights reserved.
//

#import "ZFSettingViewController.h"
@interface ZFSettingViewController ()
@property (nonatomic,strong)UITableView *setttingTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end
@implementation ZFSettingViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
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
        _setttingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _setttingTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.setttingTableView];
}
#pragma mark -uitableViewDelegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
