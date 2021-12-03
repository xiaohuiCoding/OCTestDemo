//
//  AppDelegate.m
//  OCTest
//
//  Created by xiaohui on 2018/1/31.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomViewController.h"

@interface AppDelegate ()

@property (assign, nonatomic) UIBackgroundTaskIdentifier backGroundUpdate;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"willFinishLaunching --- %f", CFAbsoluteTimeGetCurrent());
    });
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"didFinishLaunching --- %f", CFAbsoluteTimeGetCurrent());
    });
    
//    NSLog(@"%s",__func__);
//    NSLog(@"程序已经完成启动");
//    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    CustomViewController *vc = [[CustomViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
//    NSLog(@"%s",__func__);
//    NSLog(@"程序将要失去活跃");

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
//    NSLog(@"%s",__func__);
//    NSLog(@"程序已经进入后台");

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self beginBackGroundUpdate];
    [self endBackGroundUpdate]; //需要长久运行的代码
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
//    NSLog(@"%s",__func__);
//    NSLog(@"程序将要进入前台");

    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
//    NSLog(@"%s",__func__);
//    NSLog(@"程序已经变得活跃");

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
//    NSLog(@"%s",__func__);
//    NSLog(@"程序将要终止");

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - custom method

- (void)beginBackGroundUpdate
{
    self.backGroundUpdate = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackGroundUpdate];
    }];
}

- (void)endBackGroundUpdate
{
    [[UIApplication sharedApplication] endBackgroundTask:self.backGroundUpdate];
    self.backGroundUpdate = UIBackgroundTaskInvalid;
}

@end
