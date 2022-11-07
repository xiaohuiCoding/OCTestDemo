//
//  TestVC19.m
//  OCTest

//  NSOperation、NSOperationQueue的使用及控制线程执行顺序

//  Created by xiaohui on 2018/6/7.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC19.h"

#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH 100
#define CELL_SPACING 10
/**
 
 1.使用NSBlockOperation方法，所有的操作不必单独定义方法，同时解决了只能传递一个参数的问题；
 2.调用主线程队列的addOperationWithBlock:方法进行UI更新，不用再定义一个参数实体（之前必须定义一个KCImageData解决只能传递一个参数的问题）；
 3.使用NSOperation进行多线程开发可以设置最大并发线程，有效的对线程进行了控制（上面的代码运行起来你会发现打印当前进程时只有有限的线程被创建，如上面的代码设置最大线程数为15，则图片基本上是一次加载的）；
 
 **/


@interface TestVC19 ()

@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) NSMutableArray *imageURLs;

@end

@implementation TestVC19

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self layoutUI1];
//    [self layoutUI2];
    
//    [self taskCancel];
    [self taskCancel2];
}

- (void)layoutUI1 {
    _imageViews=[NSMutableArray array];
    for (int r=0; r<ROW_COUNT; r++) {
        for (int c=0; c<COLUMN_COUNT; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(50+c*ROW_WIDTH+(c*CELL_SPACING), 100+r*ROW_HEIGHT+(r*CELL_SPACING), ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
        }
    }
    
    //创建图片链接
    _imageURLs=[NSMutableArray array];
    for (NSInteger i=0; i<ROW_COUNT*COLUMN_COUNT; i++) {
        [_imageURLs addObject:[NSString stringWithFormat:@"https://raw.githubusercontent.com/wiki/xiaohuiCoding/blogImages/Demo/resource_20180611_%ld.png",i]];
    }
}

- (void)layoutUI2 {
    UIButton *startButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.frame=CGRectMake(50, 660, 100, 25);
    [startButton setTitle:@"开始加载图片" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIButton *cleanButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    cleanButton.frame=CGRectMake(280, 660, 50, 25);
    [cleanButton setTitle:@"清空" forState:UIControlStateNormal];
    [cleanButton addTarget:self action:@selector(cleanView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cleanButton];
}

- (void)cleanView {
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[UIImageView class]]) {
            [v removeFromSuperview];
        }
    }
    [self layoutUI1];
}

//NSInvocationOperation（创建调用操作）
//- (void)loadImageWithMultiThread {
//    //创建完NSInvocationOperation对象并不会调用，它由一个start方法启动操作，但是注意如果直接调用start方法，则此操作会在主线程中调用，一般不会这么操作,而是添加到NSOperationQueue中
//
//    //创建操作队列
//    NSOperationQueue *operationQueue=[[NSOperationQueue alloc]init];
//    NSInteger count = ROW_COUNT*COLUMN_COUNT;
//    for (NSInteger i=0; i<count; ++i) {
//        NSInvocationOperation *invocationOperation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(loadImageWithIndex:) object:[NSNumber numberWithInteger:i]];
//    //    [invocationOperation start];
//        //将操作添加到操作队列，添加后队列会开启一个线程执行此操作
//        [operationQueue addOperation:invocationOperation];
//    }
//}

//- (void)loadImageWithMultiThread {
//    //NSBlockOperation（创建Block操作）
//
//    //创建操作队列
//    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
//    //设置最大并发线程数
//    operationQueue.maxConcurrentOperationCount = 15;
//    NSInteger count = ROW_COUNT*COLUMN_COUNT;
//    for (NSInteger i = 0; i < count; ++i) {
////        //方法1：创建操作块添加到队列
////        //创建多线程操作
////        NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
////            [self loadImageWithIndex:[NSNumber numberWithInteger:i]];
////        }];
////        //将操作添加到操作队列
////        [operationQueue addOperation:blockOperation];
//
//        //方法2：直接使用操队列添加操作
//        [operationQueue addOperationWithBlock:^{
//            [self loadImageWithIndex:[NSNumber numberWithInteger:i]];
//        }];
//    }
//}

//控制线程执行顺序，需要设置依赖线程
//如果有优先加载最后一张图片的需求，只要设置前面的线程操作的依赖线程为最后一个操作即可
//可以看到虽然加载最后一张图片的操作最后被加入到操作队列，但是它却是被第一个执行的。操作依赖关系可以设置多个，例如A依赖于B、B依赖于C…但是千万不要设置为循环依赖关系（例如A依赖于B，B依赖于C，C又依赖于A），否则是不会被执行的。
- (void)loadImageWithMultiThread {
    //创建操作队列
    NSOperationQueue *operationQueue=[[NSOperationQueue alloc]init];
    operationQueue.maxConcurrentOperationCount=15;//设置最大并发线程数
    int count=ROW_COUNT*COLUMN_COUNT;
    NSBlockOperation *lastBlockOperation=[NSBlockOperation blockOperationWithBlock:^{
        [self loadImageWithIndex:[NSNumber numberWithInt:(count-1)]];
    }];
    //创建多个线程用于填充图片
    for (int i=0; i<count-1; ++i) {
        //方法1：创建操作块添加到队列
        //创建多线程操作
        NSBlockOperation *blockOperation=[NSBlockOperation blockOperationWithBlock:^{
            [self loadImageWithIndex:[NSNumber numberWithInt:i]];
        }];
        //设置依赖操作为最后一张图片加载操作
        [blockOperation addDependency:lastBlockOperation];
        [operationQueue addOperation:blockOperation];
    }
    //将最后一个图片的加载操作加入线程队列
    [operationQueue addOperation:lastBlockOperation];
}

- (void)loadImageWithIndex:(NSNumber *)index {
    NSInteger i = [index integerValue];
    //请求数据
    NSData *data = [self requestDataWithIndex:i];
    //更新UI界面,此处调用了主线程队列的方法（mainQueue是UI主线程）
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self updateImageWithImageData:data andIndex:i];
    }];
}

- (NSData *)requestDataWithIndex:(NSInteger)index {
    NSURL *url = [NSURL URLWithString:_imageURLs[index]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
}

- (void)updateImageWithImageData:(NSData *)data andIndex:(NSInteger)index {
    //参数imageData便是调用主线程方法时传入的withObject
    UIImage *image = [UIImage imageWithData:data];
    UIImageView *imageView = _imageViews[index];
    imageView.image = image;
}

#pragma mark - 任务取消

// 在任务开始后取消无效
- (void)taskCancel {
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1");
    }];
        
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2");
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3");
    }];
    
    [operation1 start]; // 任务1开始了
    [operation2 start]; // 任务2开始了
    [operation3 start]; // 任务3开始了
    
    [operation1 cancel]; // 取消任务1
}

// 在任务开始前取消才有效
- (void)taskCancel2 {
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1");
    }];
        
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2");
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3");
    }];
    
    [operation1 cancel];  // 取消任务1
    
    [operation1 start]; // 任务1开始了
    [operation2 start]; // 任务2开始了
    [operation3 start]; // 任务3开始了
}

@end
