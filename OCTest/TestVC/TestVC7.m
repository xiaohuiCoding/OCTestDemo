//
//  TestVC7.m
//  OCTest

//  UIView的生命周期

//  Created by xiaohui on 2018/2/10.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC7.h"
#import "UIImage+PureColor.h"
#import "UIButton+AddResponseArea.h"
#import "UIImageView+RoundedCorner.h"
#import "TestView.h"

@interface TestVC7 ()

@end

@implementation TestVC7

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 80, 100, 50)];
    view.backgroundColor = [UIColor cyanColor];
    view.layer.cornerRadius = 15;
//    view.layer.masksToBounds = NO;//默认是NO，如果设置为YES，会造成不必要的离屏渲染。
    [self.view addSubview:view];
    
    
    //在这一点上UITextField、UITextView、UILabel和UIView类似，但在设置背景色上UILabel需要注意一下，不要直接设置label.backgroundColor，而是设置label.layer.backgroundColor
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 160, 100, 30)];
    label.layer.backgroundColor = [UIColor grayColor].CGColor;
    label.layer.cornerRadius = 5;
    [self.view addSubview:label];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 220, 100, 100);
//    [btn setBackgroundColor:[UIColor redColor]];
    [btn setImage:[UIImage drawImageWithSize:btn.frame.size color:[UIColor redColor] cornerRadius:15] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    [btn addInsets:UIEdgeInsetsMake(-5, -10, -15, -25)];
//    btn.contentEdgeInsets = UIEdgeInsetsMake(-5, -10, -15, -25);
    [self.view addSubview:btn];
    
    

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 350, 100, 100)];
//    [imgView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fish" ofType:@"png"]]];
    [imgView setImage:[UIImage drawImageWithSize:imgView.frame.size color:[UIColor blueColor] cornerRadius:50]];
    [imgView drawRoundedCornerWithCornerRadius:50];
    [self.view addSubview:imgView];
    
    //一般不推荐这么做（当一个页面只有少量圆角图片时才推荐这么做）
//    imgView.layer.cornerRadius = 50;
//    imgView.layer.masksToBounds = YES;
    
    
    
    //子视图部分超出父视图，仍可响应事件
    TestView *testView = [[TestView alloc] initWithFrame:CGRectMake(80, 510, 150, 100)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.frame = CGRectMake(25, -25, 100, 150);
    [testBtn setBackgroundColor:[UIColor blueColor]];
    [testBtn addTarget:self action:@selector(test2) forControlEvents:UIControlEventTouchUpInside];
    [testView addSubview:testBtn];
    
    
    
}

- (void)test1 {
    NSLog(@"test1--->button is clicked!");
}

- (void)test2 {
    NSLog(@"test2--->button is clicked!");
}

@end
