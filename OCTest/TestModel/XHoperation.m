//
//  XHOperation.m
//  OCTest

// 自定义操作类可取消正在执行的任务

//  Created by apple on 2022/11/15.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import "XHOperation.h"

/*
 NSOperationQueue取消所有操作的方法：- (void)cancelAllOperations;
 该方法的作用是：

 取消所有操作--取消所有未执行的操作，正在执行的操作不会被取消。
 调用该方法时，会给所有的操作发送cancel消息。根据这一点，我们可以用自定义操作类，来取消正在执行的操作！

 当把操作添加到队列时，会自动先执行start方法，再执行main方法。
 将线程对象添加到可调度线程池时，会调用start方法；在线程上执行程序，入口是main函数，此时会调用main函数。
 
 1.自定义一个操作类，继承NSOperation类，以DownloadImageOperation为例。
 2.实现main方法，将要执行的异步操作都放到该方法中去实现
 3.利用isCancelled属性，在关键的地方加判断，取消后面的操作
 */

@implementation XHOperation

// 重写父类的main方法
- (void)main {
    @autoreleasepool {
        // 利用断言，要求必须传入完成的回调，简化后续代码
        NSAssert(self.finishedHandler != nil, @"断言警告！！！必须传入回调 Block");

        // 1. NSURL
        NSURL *url = [NSURL URLWithString:self.urlString];
        // 2. 沙盒路径
        NSString *filePath = [self.urlString stringByAppendingString:@"沙盒中cache文件夹的路径"];
        // 3. 获取二进制数据
        NSData *data = [NSData dataWithContentsOfURL:url];
        // 4. 保存至沙盒
        if (data != nil) {
            [data writeToFile:filePath atomically:YES];
        }
        
        // 判断是否取消
        if (self.isCancelled) {
            NSLog(@"下载操作被取消！");
            return;
        }

        // 主线程回调
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.finishedHandler([UIImage imageWithData:data]);
        }];
    }
}

@end
