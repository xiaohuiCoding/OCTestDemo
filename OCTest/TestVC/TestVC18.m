//
//  TestVC18.m
//  OCTest

//  NSThread （三）控制线程的状态

//  Created by xiaohui on 2018/4/19.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC18.h"
#import "ImageData.h"

#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH 100
#define CELL_SPACING 10

@interface TestVC18 ()

@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) NSMutableArray *threads;

@end

@implementation TestVC18

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self layoutUI1];
    [self layoutUI2];
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
}

- (void)layoutUI2 {
    UIButton *startButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.frame=CGRectMake(50, 660, 100, 25);
    [startButton setTitle:@"开始加载图片" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIButton *stopButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    stopButton.frame=CGRectMake(170, 660, 100, 25);
    [stopButton setTitle:@"停止加载图片" forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(stopLoadImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
    
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

- (void)loadImageWithMultiThread {
    NSInteger count = ROW_COUNT*COLUMN_COUNT;
    _threads = [NSMutableArray arrayWithCapacity:count];
    //创建多个线程用于填充图片
    for (NSInteger i=0; i<count; ++i) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImageWithIndex:) object:[NSNumber numberWithInteger:i]];
        thread.name = [NSString stringWithFormat:@"new thread:%li",(long)i];
        [_threads addObject:thread];
    }
    //循环启动线程
    for (NSInteger i = 0; i < count; ++i) {
        NSThread *thread = _threads[i];
        [thread start];
        NSLog(@"thread(%@) is start!",thread); // 打印已经开始了的任务
    }
}

- (void)loadImageWithIndex:(NSNumber *)index {
    //参数index便是创建线程时传入的object
    NSLog(@"current thread%@",[NSThread currentThread]);//打印当前线程的编号number和名称name
    NSInteger i = [index integerValue];
    NSLog(@"execute%ld",i);//执行顺序未必和启动顺序一致,因为线程启动后仅仅处于就绪状态，实际是否执行要由CPU根据当前状态来调度。
    NSLog(@"main thread%@",[NSThread mainThread]);//主线程的number永远是1
    NSURL *url = [NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/472309f790529822c4ac8ad0d5ca7bcb0a46d402.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSThread *currentThread = [NSThread currentThread];
    // 判断当前线程是否已取消👍
    if (currentThread.isCancelled) {
        NSLog(@"thread(%@) will be cancelled!",currentThread); // 打印会被取消的任务(已经开始了的任务)
        [NSThread exit]; // 退出线程，就会真的取消该线程任务👍
    }
    ImageData *imageData = [[ImageData alloc] init];
    imageData.index = i;
    imageData.data = data;
    [self performSelectorOnMainThread:@selector(updateImageWithImageData:) withObject:imageData waitUntilDone:YES];
}

- (void)updateImageWithImageData:(ImageData *)imageData {
    //参数imageData便是调用主线程方法时传入的withObject
    UIImage *image = [UIImage imageWithData:imageData.data];
    UIImageView *imageView = _imageViews[imageData.index];
    imageView.image = image;
}

- (void)stopLoadImage {
    for (NSInteger i=0; i<ROW_COUNT*COLUMN_COUNT; i++) {
        NSThread *thread = _threads[i];
        // 判断线程任务是否已执行完成，若未完成就取消，此时的任务已经开始但未完成👍
        if (!thread.isFinished) {
            [thread cancel]; // 取消线程的执行
        }
    }
}

@end
