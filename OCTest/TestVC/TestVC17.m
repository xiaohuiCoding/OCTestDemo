//
//  TestVC17.m
//  OCTest

//  NSThread （二）多个线程执行

//  Created by xiaohui on 2018/4/14.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC17.h"
#import "ImageData.h"

#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH 100
#define CELL_SPACING 10

@interface TestVC17 ()

@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, assign) BOOL needPriority;

@end

/*
 1.任务的管理方式：串行队列 和 并行队列
 2.任务的执行方式：同步 和 异步
 
 1. 对于单核CPU来说，不存在真正意义上的并行，所以，多线程执行任务，其实也只是一个人在干活，CPU的调度决定了非等待任务的执行速率，同时对于非等待任务，多线程并没有真正意义提高效率。
 2. 线程可以简单的认为就是一段代码+运行时数据。
 3. 同步执行会在当前线程执行任务，不具备开辟线程的能力或者说没有必要开辟新的线程。并且，同步执行必须等到Block函数执行完毕，dispatch函数才会返回，从而阻塞同一串行队列中外部方法的执行。
 4. 异步执行dispatch函数会直接返回，Block函数我们可以认为它会在下一帧加入队列，并根据所在队列目前的任务情况无限下一帧执行，从而不会阻塞当前外部任务的执行。同时，只有异步执行才有开辟新线程的必要，但是异步执行不一定会开辟新线程。
 5. 只要是队列，肯定是FIFO（先进先出），但是谁先执行完要看第1条。
 6. 只要是串行队列，肯定要等上一个任务执行完成，才能开始下一个任务。但是并行队列当上一个任务开始执行后，下一个任务就可以开始执行。
 7. 想要开辟新线程必须让任务在异步执行，想要开辟多个线程，只有让任务在并行队列中异步执行才可以。执行方式和队列类型多层组合在一定程度上能够实现对于代码执行顺序的调度。
 8. 同步+串行：未开辟新线程，串行执行任务；同步+并行：未开辟新线程，串行执行任务；异步+串行：新开辟一条线程，串行执行任务；异步+并行：开辟多条新线程，并行执行任务；在主线程中同步使用主队列执行任务，会造成死锁。
 9. 对于多核CPU来说，线程数量也不能无限开辟，线程的开辟同样会消耗资源，过多线程同时处理任务并不是想象中的人多力量大。
 
 做个比喻，如下：
 任务的管理方式——队列，串行队列和并行队列就像是人以什么规则打电话，排队一个等一个去，还是抢着去；
 任务的执行方式——同步或异步执行，就像提供当前一个电话机，还是可以申请新的电话机;
 多线程的运作就是这些人去打电话;
 同步执行的时候不能开辟新的线程，异步执行的时候可以开辟新的线程，但不一定开辟;
 */

@implementation TestVC17

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self layoutUI];
    
//    [self taskExecute];
//    [self taskExecute2];
//    [self taskExecute3];
//    [self taskExecute4];
//    [self taskExecute5];
//    [self taskExecute6];
//    [self taskExecute7];
//    [self taskExecute8];
}

// 打印 1 后发生死锁。。。
- (void)taskExecute {
    NSLog(@"1========%@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2========%@",[NSThread currentThread]);
    });
    NSLog(@"3========%@",[NSThread currentThread]);
}

// 打印 1 2 3
- (void)taskExecute2 {
    NSLog(@"1========%@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2========%@",[NSThread currentThread]);
    });
    NSLog(@"3========%@",[NSThread currentThread]);
    // 若继续追加同步任务仍然会死锁
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2========%@",[NSThread currentThread]);
//    });
}

// 打印 1 3 2
- (void)taskExecute3 {
    NSLog(@"1========%@",[NSThread currentThread]);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2========%@",[NSThread currentThread]);
    });
    NSLog(@"3========%@",[NSThread currentThread]);
//    NSLog(@"4========%@",[NSThread currentThread]);
//    NSLog(@"5========%@",[NSThread currentThread]);
    // 不管任务3后面有多少个同类型的任务，都会全部执行完后再执行任务2，因为任务2是异步执行，所以dispatch函数不会等到Block执行完成才返回，dispatch函数返回后，那任务A可以继续执行，Block任务我们可以认为在下一帧顺序加入队列，并且默认无限下一帧执行！
}

// 没有打印任何值，直接死锁
- (void)taskExecute4 {
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"1========%@",[NSThread currentThread]);
    });
//    NSLog(@"4========%@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2========%@",[NSThread currentThread]);
    });
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"3========%@",[NSThread currentThread]);
    });
}

// 打印 1 2 3 4 全部都在当前线程顺序执行，也就是说，同步执行不具备开辟新线程的能力。
- (void)taskExecute5 {
    // 串行队列 + 同步
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue.xiaohui.com", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(serialQueue, ^{
        NSLog(@"1========%@",[NSThread currentThread]);
    });
    dispatch_sync(serialQueue, ^{
        NSLog(@"2========%@",[NSThread currentThread]);
    });
    dispatch_sync(serialQueue, ^{
        NSLog(@"3========%@",[NSThread currentThread]);
    });
    NSLog(@"4========%@",[NSThread currentThread]);
}

// 打印 4 1 2 3 说明异步执行具有开辟新线程的能力，并且串行队列必须等到前一个任务执行完才能开始执行下一个任务，同时，异步执行会使内部函数率先返回，不会与正在执行的外部函数发生死锁。
- (void)taskExecute6 {
    // 串行队列 + 异步
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue.xiaohui.com", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        NSLog(@"1========%@",[NSThread currentThread]);
    });
    dispatch_async(serialQueue, ^{
        NSLog(@"2========%@",[NSThread currentThread]);
    });
    dispatch_async(serialQueue, ^{
        NSLog(@"3========%@",[NSThread currentThread]);
    });
    NSLog(@"4========%@",[NSThread currentThread]);
}

// 打印 1 2 3 4 未开启新的线程执行任务，并且Block函数执行完成后dispatch函数才会返回，才能继续向下执行，所以我们看到的结果是顺序打印的。
- (void)taskExecute7 {
    // 并行队列 + 同步
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue.xiaohui.com", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"1========%@",[NSThread currentThread]);
    });
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"2========%@",[NSThread currentThread]);
    });
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"3========%@",[NSThread currentThread]);
    });
    NSLog(@"4========%@",[NSThread currentThread]);
}

// 打印结果是随机的 开辟了多个线程，触发任务的时机是顺序的，但是我们看到完成任务的时间却是随机的，这取决于CPU对于不同线程的调度分配，但是，线程不是无条件无限开辟的，当任务量足够大时，线程是会重复利用的。
- (void)taskExecute8 {
    // 并行队列 + 异步
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue.xiaohui.com", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"1========%@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"2========%@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"3========%@",[NSThread currentThread]);
    });
    NSLog(@"4========%@",[NSThread currentThread]);
}

- (void)layoutUI {
    _imageViews=[NSMutableArray array];
    for (int r=0; r<ROW_COUNT; r++) {
        for (int c=0; c<COLUMN_COUNT; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(50+c*ROW_WIDTH+(c*CELL_SPACING), 100+r*ROW_HEIGHT+(r*CELL_SPACING), ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
        }
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(20, 650, self.view.bounds.size.width-40, 30);
    button.backgroundColor = UIColor.blackColor;
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button setTitle:@"多个线程任务顺序执行" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame=CGRectMake(20, 690, self.view.bounds.size.width-40, 30);
    button2.backgroundColor = UIColor.blackColor;
    [button2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button2 setTitle:@"多个线程任务顺序执行，指定最后一个优先执行" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(loadImageWithMultiThread2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

//创建多个线程用来加载多张图片，并按线程被创建时的顺序启动线程
- (void)loadImageWithMultiThread {
    self.needPriority = NO;
    NSInteger count = ROW_COUNT*COLUMN_COUNT;
    for (NSInteger i=0; i<count; ++i) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImageWithIndex:) object:[NSNumber numberWithInteger:i]];
        thread.name = [NSString stringWithFormat:@"new thread:%li",(long)i];
        [thread start];
    }
}

//创建多个线程用来加载多张图片，并设置最后一个线程优先启动
- (void)loadImageWithMultiThread2 {
    self.needPriority = YES;
    NSInteger count = ROW_COUNT*COLUMN_COUNT;
    //创建多个线程用来加载多张图片
    for (NSInteger i = 0; i < count; ++i) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImageWithIndex:) object:[NSNumber numberWithInteger:i]];
        thread.name = [NSString stringWithFormat:@"new thread:%li",(long)i];
        if (i == count - 1) {
            thread.threadPriority = 1.0;
        } else {
            thread.threadPriority = 0.5;
        }
        [thread start];
    }
}

- (void)loadImageWithIndex:(NSNumber *)index {
    //参数index便是创建线程时传入的object
    NSLog(@"current thread%@",[NSThread currentThread]);//打印当前线程的编号number和名称name
    NSInteger i = [index integerValue];
    NSLog(@"execute%ld",i);//执行顺序未必和启动顺序一致，因为线程启动后仅仅处于就绪状态，实际是否执行要由CPU根据当前状态来调度。
    NSLog(@"main thread%@",[NSThread mainThread]);//主线程的number永远是1
    NSData *data = [self requestDataWithIndex:i];
    ImageData *imageData = [[ImageData alloc] init];
    imageData.index = i;
    imageData.data = data;
    [self performSelectorOnMainThread:@selector(updateImageWithImageData:) withObject:imageData waitUntilDone:YES];
}

- (NSData *)requestDataWithIndex:(NSInteger)index {
//    NSURL *url = [NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/472309f790529822c4ac8ad0d5ca7bcb0a46d402.jpg"];
//    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if (self.needPriority == YES) {
        //为了更好的解决优先加载最后一张图片的问题，不妨让其他线程先休眠一会儿，等等最后一个线程，你将会看到最后一张图片总是第一个加载（除非网速特别差）。
        if (index != ROW_COUNT*COLUMN_COUNT - 1) {
            [NSThread sleepForTimeInterval:2.0];
        }
    }
    NSURL *url = [NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/472309f790529822c4ac8ad0d5ca7bcb0a46d402.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
}

- (void)updateImageWithImageData:(ImageData *)imageData {
    //参数imageData便是调用主线程方法时传入的withObject
    UIImage *image = [UIImage imageWithData:imageData.data];
    UIImageView *imageView = _imageViews[imageData.index];
    imageView.image = image;
}

@end
