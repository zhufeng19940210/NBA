//
//  AppDelegate.m
//  ZF_NBA
//
//  Created by bailing on 2017/12/4.
//  Copyright © 2017年 zhufeng. All rights reserved.
//
#import "AppDelegate.h"
#import "ZFTabBarControllerViewController.h"
#import "ZFWelcomeViewController.h"
@interface AppDelegate ()
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    BOOL notisFirst = [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"];
    if (!notisFirst) {
        ZFWelcomeViewController *welecomVc = [[ZFWelcomeViewController alloc]init];
        self.window.rootViewController = welecomVc;
    }else{
        ZFTabBarControllerViewController *tabbarVc = [[ZFTabBarControllerViewController alloc]init];
        self.window.rootViewController = tabbarVc;
    }
    [self setupLogoJson];
    //设置状态栏的样式
    application.statusBarStyle = UIStatusBarStyleLightContent;
    //程序启动完后显示状态栏
    application.statusBarHidden = NO;
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)setupLogoJson{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Team_Logo" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    self.logoDict = dic;
    NSLog(@"logoDict:%@",self.logoDict);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
