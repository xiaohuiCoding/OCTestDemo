//
//  TestVC12.m
//  OCTest

//  Runtime的应用（二）

//  Created by xiaohui on 2018/3/15.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC12.h"
#import "NSObject+AddProperty.h"
#import "NSObject+AddMethod.h"
#import "ModelA.h"

@interface TestVC12 ()

@end

@implementation TestVC12

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSObject *objc = [[NSObject alloc] init];
    objc.smallName = @"xiaohui";
    NSLog(@"%@",objc.smallName);
    
    
    
    NSDictionary *dic1 = @{@"id":@111,
                           @"name":@"xiaohui",
                           @"gender":@"male"};
//    ModelA *model1 = [ModelA simpleModelFromDictionary:dic1];
    ModelA *model1 = [ModelA modelFromDictionary:dic1];
    NSLog(@"model1:%@",model1);
    
    
    
    NSDictionary *dic2 = @{@"id":@111,
                           @"name":@"xiaohui",
                           @"gender":@"male",
                           @"otherInfo":@{@"address":@"浙江杭州", @"hobby":@"看书"}
                           };
//    ModelA *model2 = [ModelA modelInModelFromDictionary:dic2];
    ModelA *model2 = [ModelA modelFromDictionary:dic2];
    NSLog(@"model2:%@",model2);
    
    
    
//    NSDictionary *dic3 = @{@"id":@111,
//                           @"name":@"xiaohui",
//                           @"gender":@"male",
//                           @"listB":@[@{@"address":@"浙江杭州", @"hobby":@"看书"}]
//                           };
    
//    NSDictionary *dic3 = @{@"id":@111,
//                           @"name":@"xiaohui",
//                           @"gender":@"male",
//                           @"listC":@[@{@"height":@"180", @"weight":@"150"}]
//                           };
    
    NSDictionary *dic3 = @{@"id":@111,
                           @"name":@"xiaohui",
                           @"gender":@"male",
                           @"listB":@[@{@"address":@"浙江杭州", @"hobby":@"看书"}],
                           @"listC":@[@{@"height":@"180", @"weight":@"150"}]
                           };

//    ModelA *model3 = [ModelA modelInArrayFromDictionary:dic3];
    ModelA *model3 = [ModelA modelFromDictionary:dic3];
    NSLog(@"model3:%@",model3);
}

@end
