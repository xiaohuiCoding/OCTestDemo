//
//  TestVC18.m
//  OCTest
//
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
    [self layoutUI];
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
    
    UIButton *startButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.frame=CGRectMake(50, 660, 100, 25);
    [startButton setTitle:@"开始加载图片" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIButton *stopButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    stopButton.frame=CGRectMake(200, 660, 100, 25);
    [stopButton setTitle:@"停止加载图片" forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(stopLoadImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
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
    for (NSInteger i = 0; i < count; i++) {
        NSThread *thread = _threads[i];
        [thread start];
    }
}

- (void)loadImageWithIndex:(NSNumber *)index {
    //参数index便是创建线程时传入的object
    NSLog(@"current thread%@",[NSThread currentThread]);//打印当前线程的编号number和名称name
    NSInteger i = [index integerValue];
    NSLog(@"execute%ld",i);//执行顺序未必和启动顺序一致,因为线程启动后仅仅处于就绪状态，实际是否执行要由CPU根据当前状态来调度。
    NSLog(@"main thread%@",[NSThread mainThread]);//主线程的number永远是1
    NSData *data = [self requestDataWithIndex:i];
    NSThread *currentThread = [NSThread currentThread];
    if (currentThread.isCancelled) {
        NSLog(@"thread(%@) will be cancelled!",currentThread);
        [NSThread exit];
    }
    ImageData *imageData = [[ImageData alloc] init];
    imageData.index = i;
    imageData.data = data;
    [self performSelectorOnMainThread:@selector(updateImageWithImageData:) withObject:imageData waitUntilDone:YES];
}

- (NSData *)requestDataWithIndex:(NSInteger)index {
    NSURL *url = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/d/de/Bananavarieties.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
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
        if (!thread.isFinished) {
            [thread cancel];
        }
    }
}

@end
