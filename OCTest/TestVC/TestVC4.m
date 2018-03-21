//
//  TestVC4.m
//  OCTest

//  some interview topic

//  Created by xiaohui on 2018/2/10.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

//参考：https://www.jianshu.com/p/941039aba684

#import "TestVC4.h"

@interface TestVC4 ()

@end

@implementation TestVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self test1];
    [self test2];
    [self test3];
    
    //题目4、GCD
    
    /**
     考察点：GCD并发队列实现机制，以及performSelector的实现原理以及runloop了解。
     上面这段代码，只会打印before perform和after perform，不会打印printLog。
     原因：
     1、GCD默认的全局并发队列，在并发执行任务的时候，会从线程池获取可执行任务的线程（如果没有就阻塞）。
     2、performSelector的原理是设置一个timer到当前线程Runloop，并且是NSDefaultRunLoopMode；
     3、非主线程的runloop默认是不启用；
     */
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"before perform");
        [self performSelector:@selector(printLog) withObject:nil afterDelay:0];
        NSLog(@"after perform");
    });
    
    //修改代码使得“printLog”可以打印，不考虑打印的先后顺序。解决方案如下：
    
    //方案一：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"before perform");
        [self performSelector:@selector(printLog) withObject:nil afterDelay:0];
        NSLog(@"after perform");
        [[NSRunLoop currentRunLoop] run];//重启当前线程的runloop
    });
    
    //方案二：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"before perform");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelector:@selector(printLog) withObject:nil afterDelay:0];
        });//将该打印任务放到主线程执行
        NSLog(@"after perform");
    });
}

- (void)printLog {
    NSLog(@"printLog");
}

/**
 题目1、UIImage相关
 看下面一段代码，
 保存到相册的是什么？（从格式、形状去描述）
 */

- (void)test1 {
    //绘制
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    testView.backgroundColor = [UIColor redColor];
    testView.layer.cornerRadius = 50;
    testView.layer.masksToBounds = NO;
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    [testView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *testImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //展示
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = testImage;
    imageView.frame = CGRectMake(100, 100, testImage.size.width, testImage.size.height);
    [self.view addSubview:imageView];
}

/**
 题目2、URL相关
 看下面一段代码，
 写下三行Log的输出，并解释下URL是什么。
 */

- (void)test2 {
    NSString *path = @"https://www.baidu.com/";
    NSString *path2 = @"http://fanyi.baidu.com/translate?query=#auto/zh/";
    NSString *path3 = @"http://fanyi.baidu.com/translate?query=#zh/en/测试";
    
    NSURL *url = [NSURL URLWithString:path];
    NSURL *url2 = [NSURL URLWithString:path2];
    NSURL *url3 = [NSURL URLWithString:path3];
    
    NSLog(@"%@", url);
    NSLog(@"%@", url2);
    NSLog(@"%@", url3);
    
    //url中含有中文，需要重新编码，否则若用 URLWithString 来初始化会失败！
    NSString *path_3 = [path3 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url_3 = [NSURL URLWithString:path_3];
    NSLog(@"%@", url_3);
    //URL：Uniform Resource Locator，统一资源定位符，用的是ASCII编码。
}

/**
 题目3、内容为十六进制的字符串反转成十六进制
 */

- (void)test3 {
    NSLog(@"data:%@",[self dataFromHexString:@"0x7fa90842afc0"]);
}

- (NSData *)dataFromHexString:(NSString *)string {
    const char *chars = [string UTF8String];
    NSUInteger i = 0, len = string.length;
    
    NSMutableData *data = [NSMutableData dataWithCapacity:len / 2];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    while (i < len) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    
    return data;
}

@end
