//
//  TestVC17.m
//  OCTest
//
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

@end

@implementation TestVC17

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self layoutUI];
}

- (void)layoutUI {
    _imageViews=[NSMutableArray array];
    for (int r=0; r<ROW_COUNT; r++) {
        for (int c=0; c<COLUMN_COUNT; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(50+c*ROW_WIDTH+(c*CELL_SPACING), 100+r*ROW_HEIGHT+(r*CELL_SPACING                           ), ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
        }
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 660, 320, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)loadImageWithMultiThread {
    //创建多个线程用来加载多张图片，并按线程被创建时的顺序启动线程
//    NSInteger count = ROW_COUNT*COLUMN_COUNT;
//    for (NSInteger i=0; i<count; ++i) {
//        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImageWithIndex:) object:[NSNumber numberWithInteger:i]];
//        thread.name = [NSString stringWithFormat:@"new thread:%li",(long)i];
//        [thread start];
//    }
    
    
    //创建多个线程用来加载多张图片，并设置最后一个线程优先启动
    NSMutableArray *threadArray = [NSMutableArray array];
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
        [threadArray addObject:thread];
    }
    for (NSInteger i = 0; i < count; i++) {
        NSThread *thread = threadArray[i];
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
    ImageData *imageData = [[ImageData alloc] init];
    imageData.index = i;
    imageData.data = data;
    [self performSelectorOnMainThread:@selector(updateImageWithImageData:) withObject:imageData waitUntilDone:YES];
}

- (NSData *)requestDataWithIndex:(NSInteger)index {
//    NSURL *url = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/d/de/Bananavarieties.jpg"];
//    NSData *data = [NSData dataWithContentsOfURL:url];
    
    //为了更好的解决优先加载最后一张图片的问题，不妨让其他线程先休眠一会儿，等等最后一个线程，你将会看到最后一张图片总是第一个加载（除非网速特别差）。
    if (index != ROW_COUNT*COLUMN_COUNT - 1) {
        [NSThread sleepForTimeInterval:2.0];
    }
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

@end
