//
//  ZFTabBarControllerViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/4.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFTabBarControllerViewController.h"
#import "ZFGameViewController.h"
#import "ZFHomeViewController.h"
#import "ZFSettingViewController.h"
#import "ZFNavigationController.h"
@interface ZFTabBarControllerViewController ()
@end
@implementation ZFTabBarControllerViewController
+(void)initialize{
    [super initialize];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] =  [UIColor colorWithRed:(122.0f/255.0f) green:(126.0f/255.0) blue:(131.0f/255.0f) alpha:1 ];
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
}
- (void)setupChildViewVC:(UIViewController *)childVC title:(NSString *)title norImage:(NSString *)norName selectImage:(NSString *)selectImage
{
    // 标题
    childVC.title = title;
    UIImage *norImage = [UIImage imageNamed:norName];
    // 普通状态下得图片
    childVC.tabBarItem.image = [norImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置选中状态下得图片
    UIImage *selectedImage = [UIImage imageNamed:selectImage];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = selectedImage;
    // 添加导航控制器
    ZFNavigationController *nav = [[ZFNavigationController alloc]initWithRootViewController:childVC];
    // 添加tarBarController的子控制器
    [self addChildViewController:nav];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllControllers];
}
-(void)setupAllControllers{
    ZFHomeViewController *homeVc = [[ZFHomeViewController alloc]init];
    [self setupChildViewVC:homeVc title:@"篮球" norImage:@"home" selectImage:@"home2"];
    ZFGameViewController *gameVc = [[ZFGameViewController alloc]init];
    [self setupChildViewVC:gameVc title:@"球类" norImage:@"message" selectImage:@"message2"];
    ZFSettingViewController *settingVc = [[ZFSettingViewController alloc]init];
    [self setupChildViewVC:settingVc title:@"其他" norImage:@"more" selectImage:@"more2"];
}
@end
