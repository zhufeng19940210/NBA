//
//  ZFVideoViewController.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/6.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "ZFVideoViewController.h"
@interface ZFVideoViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
@implementation ZFVideoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
}
#pragma mark - uiwebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end
