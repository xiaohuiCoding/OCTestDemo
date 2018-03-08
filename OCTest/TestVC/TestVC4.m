//
//  TestVC4.m
//  OCTest

//  RunLoop（runloop与performSelector）

//  Created by xiaohui on 2018/2/10.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC4.h"

@interface TestVC4 ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation TestVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //***测试：点击屏幕的空白部分，然后立即连续拖动textView多次，观察图片是否可以在点击屏幕2s后显示出来***//
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 80, 200, 100)];
    [self.view addSubview:_imgView];
    
    
    
    UITextView *txtView = [[UITextView alloc] initWithFrame:CGRectMake(100, 240, 150, 200)];
    txtView.text = @"连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？";
    [self.view addSubview:txtView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_imgView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"fish"] afterDelay:2.0 inModes:@[NSDefaultRunLoopMode]];
    
//    [_imgView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"fish"] afterDelay:2.0 inModes:@[NSRunLoopCommonModes]];
}

@end
