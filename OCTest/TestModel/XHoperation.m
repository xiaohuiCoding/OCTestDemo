//
//  XHoperation.m
//  OCTest

// 自定义操作类可取消正在执行的任务

//  Created by apple on 2022/11/3.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import "XHoperation.h"

/*
 NSOperationQueue取消所有操作的方法：- (void)cancelAllOperations
 该方法的作用是：取消所有操作取消所有未执行的操作，正在执行的操作不会被取消。调用该方法时，会给所有的操作发送cancel消息。
 */

@implementation XHoperation

- (void)main {
    @autoreleasepool {
        // 利用断言，要求必须传入完成的回调，简化后续代码
        NSAssert(self.finishedHandler != nil, @"必须传入回调 Block");

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
            NSLog(@"下载操作被取消");
            return;
        }

        // 主线程回调
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.finishedHandler([UIImage imageWithData:data]);
        }];
    }
}

@end
