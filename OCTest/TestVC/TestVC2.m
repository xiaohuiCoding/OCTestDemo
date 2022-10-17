//
//  TestVC2.m
//  OCTest

//  为空性

//  Created by xiaohui on 2018/2/10.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC2.h"

@interface TestVC2 ()

@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //    Test_Nullability *f1 = [[Test_Nullability alloc] init1WithCompletionBlock:^(BOOL b) {
    //
    //    }];
    //
    //    Test_Nullability *f2 = [[Test_Nullability alloc] init2WithCompletionBlock:^(BOOL b) {
    //
    //    }];
    //
    //    Test_Nullability *f3 = [[Test_Nullability alloc] init3WithCompletionBlock:^(NSString * _Nullable str) {
    //
    //    }];
    //
    //    Test_Nullability *f4 = [[Test_Nullability alloc] init4WithCompletionBlock:^id _Nullable(NSString * _Nullable str) {
    //        return nil;
    //    }];
    
    
    /*
     1.对于静态不可变空对象，下面的不可变数组 1-4 都指向了同一个对象，而 数组5 指向了另一个对象，可通过打印地址看出来；
     2.若干个不可变的空数组间没有任何特异性，返回一个静态对象也理所应当；
     3.不仅是 NSArray，Foundation 中 NSString, NSDictionary, NSSet 等区分可变和不可变版本的类，空实例都是静态对象(其中NSString 的空实例对象是常量区的@"")；
     4.所以也给用这些方法来测试对象内存管理的同学提个醒，很容易意料之外的。。。
     */
     
    NSArray *arr1 = [[NSArray alloc] init];
    NSArray *arr2 = [[NSArray alloc] init];
    NSArray *arr3 = @[];
    NSArray *arr4 = @[];
    NSArray *arr5 = @[@1];
    NSLog(@"5个不可变数组的内存地址分别是：%p %p %p %p %p",arr1,arr2,arr3,arr4,arr5); // 前4个是：0x7fff8a62da10 第5个是：0x6000028fded0
}

@end
