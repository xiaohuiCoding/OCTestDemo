//
//  TestVC16.m
//  OCTest

//  NSThread 解决线程阻塞

//  Created by xiaohui on 2018/4/12.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC16.h"

@interface TestVC16 ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation TestVC16

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"more" style:UIBarButtonItemStylePlain target:self action:@selector(toNextPage)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)toNextPage {
    
}

- (IBAction)loadImageWithMultiThread:(id)sender {
    
//    [self loadImage]; //不创建线程，直接默认在主线程执行下载操作，在下载完成前无法点击测试按钮，这就是线程阻塞。
    
    //使用对象方法创建一个线程
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImage) object:nil];
//    //启动一个线程，注意启动一个线程并非就一定立即执行，而是处于就绪状态，当系统调度时才真正执行。
//    [thread start];
    
    //使用类方法创建一个线程
    [NSThread detachNewThreadSelector:@selector(loadImage) toTarget:self withObject:nil];
}

- (NSData *)requestData {
    NSURL *url = [NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/472309f790529822c4ac8ad0d5ca7bcb0a46d402.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
}

- (void)loadImage {
    NSData *data = [self requestData];
    //在主线程更新UI
    [self performSelectorOnMainThread:@selector(updateImageWithData:) withObject:data waitUntilDone:YES];
}

- (void)updateImageWithData:(NSData *)imageData {
    UIImage *image = [UIImage imageWithData:imageData];
    _imgView.image = image;
}

@end
