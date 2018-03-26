//
//  TestVC15.m
//  OCTest

//  GCD的使用（一）

//  Created by xiaohui on 2018/3/21.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC15.h"

void async_f_callback(void *context) {
    NSLog(@"async_f_callback is invoked");
    NSString *s_context = (__bridge NSString *)context;
    NSLog(@"s_context%@", s_context);
}

@interface TestVC15 ()

@end

@implementation TestVC15

- (void)basicTest {
    //获取全局队列（并行）
    dispatch_queue_t queueGlobal;
    queueGlobal = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    //获取主队列（串行）
    dispatch_queue_t queueMain;
    queueMain = dispatch_get_main_queue();
    
    //创建自定义的队列
    dispatch_queue_t queueCustom;
    queueCustom = dispatch_queue_create("com.xiaohui.111", DISPATCH_QUEUE_CONCURRENT);
    

    
    //自定义队列的优先级（dispatch_queue_attr_make_with_qos_class）
    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, -1);
    dispatch_queue_t queueCustom2;
    queueCustom2 = dispatch_queue_create("com.xiaohui.112", attr);
    
    
    
    //设置队列优先级（dispatch_set_target_queue）
    dispatch_queue_t queueCustom3 = dispatch_queue_create("com.xiaohui.113", NULL);
    dispatch_queue_t queueCustom4 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_set_target_queue(queueCustom3, queueCustom4);//使二者的优先级一样
    
    dispatch_async(queueCustom3, ^{
        NSLog(@"queueCustom3");
    });
    
    dispatch_async(queueCustom4, ^{
        NSLog(@"queueCustom4");
    });
    
    
    
    //设置队列层级体系，比如：让多个串行和并行队列在统一一个串行队列里串行执行
    dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t firstQueue = dispatch_queue_create("com.starming.gcddemo.firstqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t secondQueue = dispatch_queue_create("com.starming.gcddemo.secondqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_set_target_queue(firstQueue, serialQueue);
    dispatch_set_target_queue(secondQueue, serialQueue);
    
    dispatch_async(firstQueue, ^{
        NSLog(@"1");
        [NSThread sleepForTimeInterval:1.f];
    });
    
    dispatch_async(secondQueue, ^{
        NSLog(@"2");
        [NSThread sleepForTimeInterval:1.f];
    });
    
    dispatch_async(secondQueue, ^{
        NSLog(@"3");
        [NSThread sleepForTimeInterval:1.f];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //一些基本用法
    [self basicTest];
    
    
    //串行队列
    
    //    dispatch_queue_t queue_serial = dispatch_queue_create("com.xiaohui.serial", DISPATCH_QUEUE_SERIAL);
    //
    //    dispatch_sync(queue_serial, ^{
    //        NSLog(@"block0");
    //    });
    //
    //    dispatch_sync(queue_serial, ^{
    //        NSLog(@"block1");
    //    });
    //
    //    dispatch_sync(queue_serial, ^{
    //        NSLog(@"block2");
    //    });
    //
    //    dispatch_sync(queue_serial, ^{
    //        NSLog(@"block3");
    //    });
    //
    //    dispatch_sync(queue_serial, ^{
    //        NSLog(@"block4");
    //    });
    //
    //    NSLog(@"done");
    
    
    
    //并行队列
    
    //    dispatch_queue_t queue_concurrent = dispatch_queue_create("com.xiaohui.gcd.concurrent", DISPATCH_QUEUE_CONCURRENT);
    //
    //    dispatch_async(queue_concurrent, ^{
    //        NSLog(@"block0");
    //    });
    //
    //    dispatch_async(queue_concurrent, ^{
    //        NSLog(@"block1");
    //    });
    //
    //    dispatch_async(queue_concurrent, ^{
    //        NSLog(@"block2");
    //    });
    //
    //    dispatch_async(queue_concurrent, ^{
    //        NSLog(@"block3");
    //    });
    //
    //    dispatch_async(queue_concurrent, ^{
    //        NSLog(@"block4");
    //    });
    //
    //    NSLog(@"done");
    
    
    
    //dispatch_async_f
    
    //    NSString *s_context = @"Hello world";
    //    dispatch_queue_t queue_concurrent = dispatch_queue_create("com.xiaohui.gcd.concurrent", DISPATCH_QUEUE_CONCURRENT);
    //    dispatch_async_f(queue_concurrent, (__bridge void * _Nullable)(s_context), async_f_callback);
    //    NSLog(@"dispatch_async is invoked done");
}

@end

