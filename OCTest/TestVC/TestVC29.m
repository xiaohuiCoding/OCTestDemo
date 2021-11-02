//
//  TestVC29.m
//  OCTest

//  Crash解析（三）崩溃信息分析 定位代码

//  Created by Apple on 2021/10/30.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import "TestVC29.h"

/*
 参考：
 https://zhuanlan.zhihu.com/p/44215067
 https://blog.csdn.net/skylin19840101/article/details/51595503
 https://blog.csdn.net/skylin19840101/article/details/51595622
 https://mp.weixin.qq.com/s/loZwPPzl-vhNYrmqpU7gkw
 */

@interface TestVC29 ()

@end

@implementation TestVC29

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

// 在线进制转换： https://tool.lu/hexconvert/

/*
 给定一个随意的数字，如何区分它是几进制？？？
 二进制：里面只有0和1
 八进制: 以0开头的数,如075,023,012等.每单个数在0-7之间(含).
 十六进制: 以0x开头的数,如0x12,x12ff,0x86等.
 十进制: 第一位数不是0,不以0x开头.每单个数在0-9之间(含).
 */

@end
