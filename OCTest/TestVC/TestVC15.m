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
{
    dispatch_semaphore_t semaphoreLock;
}
@property (nonatomic, assign) int ticketSurplusCount;
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

- (void)printLog {
    NSLog(@"2");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"1");
//        [self performSelector:@selector(printLog)
//                   withObject:nil
//                   afterDelay:1];
//        NSLog(@"3");
//    });
    
    //1.一些基本用法
//    [self basicTest];
    
    
    
    //2.两种常见的死锁场景：
    
    //第一种：同步执行主队列任务
    
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"111111");
//    });
//    NSLog(@"222222");
//
//    //可更改如下：
//    dispatch_sync(dispatch_queue_create("com.xiaohui.serial", DISPATCH_QUEUE_SERIAL), ^{
//        NSLog(@"111111");
//    });
//    NSLog(@"222222");
//
//    //或：
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"111111");
//    });
//    NSLog(@"222222");
//
//    //或：
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"111111");
//        });
//    });
//    NSLog(@"222222");

    
    //第二种：在同一个同步串行队列中，再使用该串行队列同步地执行任务
    
//    dispatch_queue_t queue = dispatch_queue_create("com.xiaohui.serial", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_sync(queue, ^{
//
//        NSLog(@"111111");
//
//        dispatch_sync(queue, ^{
//            NSLog(@"22222");
//        });
//
//        NSLog(@"3333333");
//
//    });
//
//    NSLog(@"44444444");
    
    
    
    //3.几种队列+任务组合
    
    //串行同步
    
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
    
    
    
    //串行异步
    
//    dispatch_queue_t queue_serial = dispatch_queue_create("com.xiaohui.serial", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_async(queue_serial, ^{
//        NSLog(@"block0");
//    });
//
//    dispatch_async(queue_serial, ^{
//        NSLog(@"block1");
//    });
//
//    dispatch_async(queue_serial, ^{
//        NSLog(@"block2");
//    });
//
//    dispatch_async(queue_serial, ^{
//        NSLog(@"block3");
//    });
//
//    dispatch_async(queue_serial, ^{
//        NSLog(@"block4");
//    });
//
//    NSLog(@"done");
    
    
    
    //并行同步
    
//    dispatch_queue_t queue_concurrent = dispatch_queue_create("com.xiaohui.concurrent", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_sync(queue_concurrent, ^{
//        NSLog(@"block0");
//    });
//
//    dispatch_sync(queue_concurrent, ^{
//        NSLog(@"block1");
//    });
//
//    dispatch_sync(queue_concurrent, ^{
//        NSLog(@"block2");
//    });
//
//    dispatch_sync(queue_concurrent, ^{
//        NSLog(@"block3");
//    });
//
//    dispatch_sync(queue_concurrent, ^{
//        NSLog(@"block4");
//    });
//
//    NSLog(@"done");
    
    
    
    //并行异步
    
//    dispatch_queue_t queue_concurrent = dispatch_queue_create("com.xiaohui.concurrent", DISPATCH_QUEUE_CONCURRENT);
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
    
    
    
    //4.dispatch_async_f
    
    //    NSString *s_context = @"Hello world";
    //    dispatch_queue_t queue_concurrent = dispatch_queue_create("com.xiaohui.gcd.concurrent", DISPATCH_QUEUE_CONCURRENT);
    //    dispatch_async_f(queue_concurrent, (__bridge void * _Nullable)(s_context), async_f_callback);
    //    NSLog(@"dispatch_async is invoked done");
    
    
    
    //几种死锁及解决办法
    
//    [self deadLockCase1];
//    [self deadLockCase2];
//    [self deadLockCase3];
//    [self deadLockCase4];
    [self deadLockCase5];
    
    
    
    //dispatch_after(延时执行)
    
    //该函数并不是在指定时间之后才开始执行处理，而是在指定时间之后将任务追加到主队列中。严格来说，这个时间并不是绝对准确的，但想要大致延迟执行任务，dispatch_after函数是很有效的。
    
//    self.navigationItem.prompt = @"哈哈";
//    dispatch_after(dispatch_time(DISPATCH_TIME_FOREVER, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.navigationItem.prompt = nil;
//    });
    
    
    
    //dispatch_apply(快速迭代)
    
    //如果是在串行队列中使用 dispatch_apply，那么就和 for 循环一样，按顺序同步执行。可这样就体现不出快速迭代的意义了。我们可以利用并发队列进行异步执行。比如说遍历 0~9 这10个数字，for 循环的做法是每次取出一个元素，逐个遍历。dispatch_apply 可以 在多个线程中同时（异步）遍历多个数字。
    //无论是在串行队列，还是异步队列中，dispatch_apply 都会等待全部任务执行完毕，这点就像是同步操作，也像是队列组中的 dispatch_group_wait方法。
    
//    __block NSInteger sum = 0;
//    NSLog(@"apply---begin");
//    //计算0-9之和
//    dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
//        sum += index;
//    });
//    NSLog(@"%ld",sum);
//    NSLog(@"apply---end");
    
    
    
    //dispatch_group_async
    //dispatch_group_enter、dispatch_group_leave组合等同于dispatch_group_async。
    //dispatch_group_notify
    //dispatch_group_wait 会阻塞当前线程
    
    //有时候我们会有这样的需求：分别异步执行2个耗时任务，然后当2个耗时任务都执行完毕后再回到主线程执行任务。这时候我们可以用到 GCD 的队列组。
    
//    __block NSInteger num = 0;
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        num = 1;
//        NSLog(@"%ld",num);
//    });
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        num = 2;
//        NSLog(@"%ld",num);
//    });
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"result = %ld",num);
//    });
////    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    NSLog(@"result = %ld",num);
    
    
    
    //dispatch_semaphore_t 实现线程同步，将异步执行任务转换为同步执行任务。
    
//    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
//    NSLog(@"semaphore---begin");
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    __block int number = 0;
//    dispatch_async(queue, ^{
//        // 追加任务1
//        NSLog(@"1---%@",[NSThread currentThread]);
//        number = 100;
//        dispatch_semaphore_signal(semaphore);
//    });
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    NSLog(@"semaphore---end,number = %d",number);
    
    
    
    //dispatch_semaphore_t 实现线程安全
    
//    [self initTicketStatusSave];
    
    
    
    //dispatch_semaphore_t 控制最大并发数
//    dispatch_queue_t workConcurrentQueue = dispatch_queue_create("cccccccc", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t serialQueue = dispatch_queue_create("sssssssss",DISPATCH_QUEUE_SERIAL);
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(3);
//
//    for (NSInteger i = 0; i < 10; i++) {
//        dispatch_async(serialQueue, ^{
//            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//            dispatch_async(workConcurrentQueue, ^{
//                NSLog(@"thread-info:%@开始执行任务%d",[NSThread currentThread],(int)i);
//                sleep(1);
//                NSLog(@"thread-info:%@结束执行任务%d",[NSThread currentThread],(int)i);
//                dispatch_semaphore_signal(semaphore);});
//        });
//    }
//    NSLog(@"主线程...!");
    
    
    
    
    //如何取消线程中的任务？
    
}

/**
 * 线程安全：使用 semaphore 加锁
 * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 */
- (void)initTicketStatusSave {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    
    self.ticketSurplusCount = 50;
    
    semaphoreLock = dispatch_semaphore_create(1);

    // queue1 代表北京火车票售卖窗口
    dispatch_queue_t queue1 = dispatch_queue_create("testQueue1", DISPATCH_QUEUE_SERIAL);
    
    // queue2 代表上海火车票售卖窗口
    dispatch_queue_t queue2 = dispatch_queue_create("testQueue2", DISPATCH_QUEUE_SERIAL);
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(queue1, ^{
        [weakSelf saleTicketSafe];
    });
    
    dispatch_async(queue2, ^{
        [weakSelf saleTicketSafe];
    });
}

/**
 * 售卖火车票(线程安全)
 */
- (void)saleTicketSafe {
    while (1) {
        // 相当于加锁
        dispatch_semaphore_wait(semaphoreLock, DISPATCH_TIME_FOREVER);
        
        if (self.ticketSurplusCount > 0) {  //如果还有票，继续售卖
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.1];
        } else { //如果已卖完，关闭售票窗口
            NSLog(@"所有火车票均已售完");
            break;
        }
        
        // 相当于解锁
        dispatch_semaphore_signal(semaphoreLock);
    }
}

- (void)deadLockCase1 {
    //主队列的同步线程，按照FIFO的原则（先入先出），2排在3后面会等3执行完，但因为同步线程，3又要等2执行完，相互等待成为死锁。
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}

- (void)deadLockCase2 {
    //3会等2，因为2在全局并行队列里，不需要等待3，这样2执行完回到主队列，3就开始执行
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}

- (void)deadLockCase3 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
        //串行队列里面同步一个串行队列就会死锁
        dispatch_sync(serialQueue, ^{
            NSLog(@"3");
        });
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"3");//这么做就可以不锁，同deadLockCase4
//        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)deadLockCase4 {
    NSLog(@"1");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
        //将同步的串行队列放到另外一个线程就能够解决
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)deadLockCase5 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        //回到主线程发现死循环后面就没法执行了
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    NSLog(@"4");
    //死循环
    while (1) {
        //do something
    }
}

@end
