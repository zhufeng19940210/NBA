//
//  ZFWelcomeViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/4.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFWelcomeViewController.h"
#import "ZFTabBarControllerViewController.h"
@interface ZFWelcomeViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *myPageControl;
@end
@implementation ZFWelcomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
    [self setupPagControl];
}
-(void)setupScrollView{
    UIImageView *imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"welcome_one.png"]];
    UIImageView *imageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"welcome_two.png"]];
    UIImageView *imageView3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"welcome_two.png"]];
    imageView1.frame = CGRectMake(0, 0, ZFScreenW, ZFScreenH);
    imageView2.frame = CGRectMake(ZFScreenW, 0, ZFScreenW, ZFScreenH);
    imageView3.frame = CGRectMake(2*ZFScreenW, 0, ZFScreenW, ZFScreenH);
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView3.contentMode  =UIViewContentModeScaleAspectFit;
    imageView3.userInteractionEnabled = YES;
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:(33.0f/255.0f) green:(203.0f/255.0f) blue:(200.0f/255.0f) alpha:1.0] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    button.layer.cornerRadius = 20.0f;
    button.frame = CGRectMake(0, 0, 120, 40);
    button.center = CGPointMake(imageView2.frame.size.width *0.5, imageView2.frame.size.height *0.92);
    [button addTarget:self action:@selector(enterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView3 addSubview:button];
    [self.myScrollView addSubview:imageView1];
    [self.myScrollView addSubview:imageView2];
    [self.myScrollView addSubview:imageView3];
    self.myScrollView.contentSize = CGSizeMake(ZFScreenW *3, ZFScreenH);
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.delegate = self;
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.showsVerticalScrollIndicator = NO;
    self.myScrollView.bounces = NO;
}
-(void)setupPagControl{
    self.myPageControl.numberOfPages = 3;
    self.myPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.myPageControl.pageIndicatorTintColor = [UIColor grayColor];
}
#pragma mark -uiscollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    long int page = lroundf(scrollView.contentOffset.x/scrollView.frame.size.width);
    self.myPageControl.currentPage = page;
    if (page == 2) {
        self.myPageControl.hidden = YES;
    }else{
        self.myPageControl.hidden = NO;
    }
}
-(void)enterBtnClick{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstLaunch"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    ZFTabBarControllerViewController *tabbarVc = [[ZFTabBarControllerViewController alloc]init];
    [self presentViewController:tabbarVc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
