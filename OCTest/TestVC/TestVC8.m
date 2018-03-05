//
//  TestVC8.m
//  OCTest

//  Block

//  Created by xiaohui on 2018/3/1.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC8.h"

//int (^blk)(int) = ^(int count) {
//    return count + 1;
//};

typedef int (^blk)(int count);

@interface TestVC8 ()

@end

@implementation TestVC8

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

@end
