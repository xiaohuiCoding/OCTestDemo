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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self basicUsage];
//
//    [self aWonderingCase];
    
//    [self threadDeadlock];
    
//    [self threadSync];
    
//    [self threadSafe];
    
//    [self threadTaskCancel];
    
    
    
    // 多任务按照一定的顺序执行
    // 方案一：条件锁：https://blog.csdn.net/qq_33226881/article/details/87863184
    
    // 方案二：通过NSOperationQueue中的依赖关系来操作，NSOperation是对GCD的封装，其优点是高于GCD的，这种只能保证任务执行的顺序，不保证任务结果的输出顺序(任务里的操作可能是异步的，需要等待回调的结果，反之如果是同步的操作是可以保证顺序的)
    NSOperationQueue *queueTest = [[NSOperationQueue alloc] init];
    queueTest.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *operationOne = [NSBlockOperation blockOperationWithBlock:^{
        [self event:1];
    }];
    NSBlockOperation *operationTwo = [NSBlockOperation blockOperationWithBlock:^{
        [self event:2];
    }];
    
    NSBlockOperation *operationThree = [NSBlockOperation blockOperationWithBlock:^{
        [self event:3];
    }];
    
    [operationTwo addDependency:operationOne];
    [operationThree addDependency:operationTwo];
    
    [queueTest addOperation:operationOne];
    [queueTest addOperation:operationTwo];
    [queueTest addOperation:operationThree];
}

- (void)event:(NSInteger)index {
    for (NSInteger i = 0; i < 10; i++) {
        NSLog(@"任务%ld的输出结果 --- %ld",(long)index,(long)i);
    }
}

#pragma mark - 基础概念及基本使用

- (void)basicUsage {
    //获取全局队列（并行）
//    dispatch_queue_t queueGlobal;
//    queueGlobal = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//
//    //获取主队列（串行）
//    dispatch_queue_t queueMain;
//    queueMain = dispatch_get_main_queue();
//
//    //创建自定义的队列
//    dispatch_queue_t queueCustom;
//    queueCustom = dispatch_queue_create("com.xiaohui.111", DISPATCH_QUEUE_CONCURRENT);
//
//
//
//    //自定义队列的优先级（dispatch_queue_attr_make_with_qos_class）
//    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, -1);
//    dispatch_queue_t queueCustom2;
//    queueCustom2 = dispatch_queue_create("com.xiaohui.112", attr);
    
    
    
    //设置队列优先级（dispatch_set_target_queue）
//    dispatch_queue_t queueCustom3 = dispatch_queue_create("com.xiaohui.113", NULL);
//    dispatch_queue_t queueCustom4 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
//    dispatch_set_target_queue(queueCustom3, queueCustom4);//使二者的优先级一样
//
//    dispatch_async(queueCustom3, ^{
//        NSLog(@"queueCustom3");
//    });
//
//    dispatch_async(queueCustom4, ^{
//        NSLog(@"queueCustom4");
//    });
    
    
    
    //设置队列层级体系，比如：让多个串行和并行队列在统一一个串行队列里串行执行
//    dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t firstQueue = dispatch_queue_create("com.starming.gcddemo.firstqueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t secondQueue = dispatch_queue_create("com.starming.gcddemo.secondqueue", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_set_target_queue(firstQueue, serialQueue);
//    dispatch_set_target_queue(secondQueue, serialQueue);
//
//    dispatch_async(firstQueue, ^{
//        NSLog(@"1");
//        [NSThread sleepForTimeInterval:1.f];
//    });
//
//    dispatch_async(secondQueue, ^{
//        NSLog(@"2");
//        [NSThread sleepForTimeInterval:1.f];
//    });
//
//    dispatch_async(secondQueue, ^{
//        NSLog(@"3");
//        [NSThread sleepForTimeInterval:1.f];
//    });
    
    
    //几种（队列 + 任务）组合
    
    //1.串行同步
    
//    dispatch_queue_t queue_serial = dispatch_queue_create("com.xiaohui.serial", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_sync(queue_serial, ^{
//        NSLog(@"block0");
//    });
//
//    dispatch_sync(queue_serial, ^{
//        NSLog(@"block1");
//    });
//    NSLog(@"done");
    
    
    //2.串行异步
    
//    dispatch_queue_t queue_serial = dispatch_queue_create("com.xiaohui.serial", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_async(queue_serial, ^{
//        NSLog(@"block0");
//    });
//
//    dispatch_async(queue_serial, ^{
//        NSLog(@"block1");
//    });
//    NSLog(@"done");
    
    
    //3.并行同步
    
//    dispatch_queue_t queue_concurrent = dispatch_queue_create("com.xiaohui.concurrent", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_sync(queue_concurrent, ^{
//        NSLog(@"block0");
//    });
//
//    dispatch_sync(queue_concurrent, ^{
//        NSLog(@"block1");
//    });
//    NSLog(@"done");
    
    
    //4.并行异步
    
//    dispatch_queue_t queue_concurrent = dispatch_queue_create("com.xiaohui.concurrent", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_async(queue_concurrent, ^{
//        NSLog(@"block0");
//    });
//
//    dispatch_async(queue_concurrent, ^{
//        NSLog(@"block1");
//    });
//    NSLog(@"done");
    
    
    
    //dispatch_async_f
        
//    NSString *s_context = @"Hello world";
//    dispatch_queue_t queue_concurrent = dispatch_queue_create("com.xiaohui.gcd.concurrent", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async_f(queue_concurrent, (__bridge void * _Nullable)(s_context), async_f_callback);
//    NSLog(@"dispatch_async is invoked done");
        
    

    //dispatch_after（延时执行）
    
    //该函数并不是在指定时间之后才开始执行处理，而是在指定时间之后将任务追加到主队列中。严格来说，这个时间并不是绝对准确的，但想要大致延迟执行任务，dispatch_after函数是很有效的。
        
//    self.navigationItem.prompt = @"哈哈";
//    dispatch_after(dispatch_time(DISPATCH_TIME_FOREVER, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.navigationItem.prompt = nil;
//    });



    //dispatch_apply（快速迭代）
    
    // 如果是在串行队列中使用 dispatch_apply，那么就和 for 循环一样，按顺序同步执行。可这样就体现不出快速迭代的意义了。我们可以利用并发队列进行异步执行。比如说遍历 0~9 这10个数字，for 循环的做法是每次取出一个元素，逐个遍历。dispatch_apply 可以 在多个线程中同时（异步）遍历多个数字。
    // 无论是在串行队列，还是异步队列中，dispatch_apply 都会等待全部任务执行完毕，这点就像是同步操作，也像是队列组中的 dispatch_group_wait方法。
    
    // 计算0-9累加的结果
//    __block NSInteger sum = 0;
//    NSLog(@"apply---begin");
//
//    dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
//        sum += index;
//    });
//    NSLog(@"%ld",sum);
//    NSLog(@"apply---end");
    
    
    
    // dispatch_group_t（队列组）
    
    //dispatch_group_async
    //dispatch_group_enter、dispatch_group_leave组合等同于dispatch_group_async。
    //dispatch_group_notify
    //dispatch_group_wait
    
    //需求场景：分别异步执行2个耗时任务，然后当2个耗时任务都执行完毕后再回到主线程执行任务。
    
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
//    // 如果加上下面一句，则123会在result之前打印，因为wait会阻塞当前线程。
//    //dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    NSLog(@"123");
}

#pragma mark - 一个疑惑的例子

- (void)aWonderingCase {
    // 下面两种情况的打印结果和我预期的不同~~
    
    // 1.同步执行全局队列的任务（打印1 3 2）
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        [self performSelector:@selector(delayLog) withObject:nil afterDelay:1.0];
        NSLog(@"3");
    });
    
    // 2.异步执行全局队列的任务（打印1 3）
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        [self performSelector:@selector(delayLog) withObject:nil afterDelay:1.0];
        NSLog(@"3");
    });
}

- (void)delayLog {
    NSLog(@"2");
}

#pragma mark - 线程死锁

- (void)threadDeadlock {
//    [self deadLockCase1];
//    [self deadLockCase2];
//    [self deadLockCase3];
//    [self deadLockCase4];
//    [self deadLockCase5];
}

- (void)deadLockCase1 {
    // 同步执行主队列的任务（按照FIFO的原则，1排在2后面会等2执行完，但因为同步线程，2又要等1执行完，相互等待造成死锁。）
            
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"1");
    });
    NSLog(@"2");

    // 解决方案如下：
    
    // 1.同步执行全局队列的任务（打印1 2）
    //2会等1，因为1在全局并行队列里，不需要等待2，这样1执行完回到主队列，就开始执行2

//    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"1");
//    });
//    NSLog(@"2");
    
    
    // 2.同步执行自定义串行队列的任务（打印1 2）
//    dispatch_sync(dispatch_queue_create("com.xiaohui.serial", DISPATCH_QUEUE_SERIAL), ^{
//        NSLog(@"1");
//    });
//    NSLog(@"2");

    
    // 3.异步执行主队列的任务（打印2 1）
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"1");
//    });
//    NSLog(@"2");

    
    // 4.异步执行全局队列的任务（打印2 1）
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"1");
//        });
//    });
//    NSLog(@"2");
}

- (void)deadLockCase2 {
    // 在一个自定义的同步串行队列中，再使用该串行队列同步执行任务
            
    dispatch_queue_t serialQueue = dispatch_queue_create("com.xiaohui.serial", DISPATCH_QUEUE_SERIAL);

    dispatch_sync(serialQueue, ^{
        NSLog(@"1");

        dispatch_sync(serialQueue, ^{
            NSLog(@"2");
        });

        NSLog(@"3");
    });

    NSLog(@"4");
        
    // 解决方案如下：
    
    // 将串行队列中的任务由同步执行改为异步执行（打印1 3 4 2）
    
//    dispatch_queue_t serialQueue = dispatch_queue_create("com.xiaohui.serial", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_sync(serialQueue, ^{
//        NSLog(@"1");
//
//        dispatch_async(serialQueue, ^{
//            NSLog(@"2");
//        });
//
//        NSLog(@"3");
//    });
//
//    NSLog(@"4");
}

- (void)deadLockCase3 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
        // 串行队列里面同步一个串行队列就会死锁
        dispatch_sync(serialQueue, ^{
            NSLog(@"3");
        });
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"3"); // 这么做就可以不锁，同deadLockCase4
//        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)deadLockCase4 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        // 将同步的串行队列放到另外一个线程就能够解决
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    NSLog(@"4");
}

- (void)deadLockCase5 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        // 回到主线程发现死循环后面就没法执行了
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    NSLog(@"4");
    // 死循环
    while (1) {
        // do something
    }
}

#pragma mark - 线程同步

- (void)threadSync {
    //使用 dispatch_semaphore_t（信号量）实现线程同步，将异步执行任务转换为同步执行任务。
        
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
    
    
    // 另外，还可以使用 dispatch_semaphore_t 控制最大并发数
    
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
}

#pragma mark - 线程安全

/**
 * 线程安全：使用 semaphore 加锁
 * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 */
- (void)threadSafe {
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

#pragma mark - 线程任务取消

- (void)threadTaskCancel {
    //GCD如何取消线程？
        
        //1.自定义变量，标记任务是否需要取消
        
    //    __block BOOL needCancel = NO;
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //        for (NSInteger i=0; i<1000; i++) {
    //            NSLog(@"第%ld次打印",i+1);
    //            sleep(1);
    //            if (needCancel) {
    //                NSLog(@"停止！");
    //                return;
    //            }
    //        }
    //    });
    //
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        needCancel = YES;
    //    });
        
        
        
        //2.iOS8之后可以调用dispatch_block_cancel来取消尚未执行的任务（需要注意必须用dispatch_block_create创建dispatch_block_t）
        
    //    dispatch_block_t block1 = dispatch_block_create(0, ^{
    //        sleep(1);
    //        NSLog(@"block1执行");
    //    });
    //
    //    dispatch_block_t block2 = dispatch_block_create(0, ^{
    //        sleep(1);
    //        NSLog(@"block2执行");
    //    });
    //
    //    dispatch_block_t block3 = dispatch_block_create(0, ^{
    //        sleep(1);
    //        NSLog(@"block3执行");
    //    });
    //
    //    dispatch_queue_t queue = dispatch_queue_create("com.xiaohui.test", DISPATCH_QUEUE_CONCURRENT);
    //
    //    dispatch_async(queue, block1);
    //    dispatch_async(queue, block2);
    //    dispatch_block_cancel(block3);
    //
    //    //dispatch_block_testcancel 判断是否成功取消，不为0则成功，否则失败。
    //    long success = dispatch_block_testcancel(block3);
    //    if (success != 0) {
    //        NSLog(@"成功取消");
    //    }
}

@end
