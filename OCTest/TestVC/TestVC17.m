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
    for (NSInteger i=0; i<ROW_COUNT*COLUMN_COUNT; ++i) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImageWithIndex:) object:[NSNumber numberWithInteger:i]];
        thread.name = [NSString stringWithFormat:@"%li",(long)i];
        [thread start];
    }
}

- (void)loadImageWithIndex:(NSNumber *)index {
    NSLog(@"current thread%@",[NSThread currentThread]);
    NSInteger i = [index integerValue];
    NSData *data = [self requestDataWithIndex:i];
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
    UIImage *image = [UIImage imageWithData:imageData.data];
    UIImageView *imageView = _imageViews[imageData.index];
    imageView.image = image;
}

@end
