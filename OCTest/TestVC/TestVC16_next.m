//
//  TestVC16_next.m
//  OCTest

//  NSThread 多线程并发执行

//  Created by xiaohui on 2018/4/12.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC16_next.h"

@interface TestVC16_next ()

@property (nonatomic, strong) NSMutableArray *imageViews;

@end

@implementation TestVC16_next

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutUI];
}

#pragma mark 界面布局
-(void)layoutUI{
    //创建多个图片控件用于显示图片
    _imageViews=[NSMutableArray array];
    for (int r=0; r<3; r++) {
        for (int c=0; c<3; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(50+c*80+c*10, 100+r*80+r*10, 80, 80)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
        }
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)loadImageWithMultiThread {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
