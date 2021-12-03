//
//  TestVC11.m
//  OCTest

//  Runtime的应用（一）

//  Created by xiaohui on 2018/3/15.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

/* OC的动态性：
 https://www.jianshu.com/p/40229034a3f9
 https://www.cnblogs.com/dxb123456/p/5525343.html
 */

#import "TestVC11.h"
#import "RuntimeTestModel.h"
#import "ModelA.h"
#import "ModelB.h"

@interface TestVC11 ()

@end

@implementation TestVC11

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RuntimeTestModel *testModel = [[RuntimeTestModel alloc] init];
    [testModel test1];
    [testModel test2];
    
    ModelA *modelA = [[ModelA alloc] init];
    [modelA test];
    
    ModelB *modelB = [[ModelB alloc] init];
    [modelB test];
}

@end
