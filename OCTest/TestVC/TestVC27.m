//
//  TestVC27.m
//  OCTest

//  Crash解析（一）代码逻辑的bug

//  Created by Apple on 2021/10/27.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import "TestVC27.h"
//#import "NSMutableArray+Safe.h"

@interface TestVC27 ()

@end

@implementation TestVC27

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1.数组越界
    // 略。
    
    // 2、给可变数组添加nil对象
    // 执行结果：这种情况程序是会crash的，控制台输出：*** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSArrayM insertObject:atIndex:]: object cannot be nil'
    // 解决方案：利用runtime原理实现方法交换避免程序crash
    NSMutableArray *array = [NSMutableArray array];
    NSObject *obj = nil;
    [array addObject:obj];
    NSLog(@"%@",array);
    
    // 3、访问野指针
    /*参考：
     https://www.jianshu.com/p/8aba0ee41cd7
     https://www.jianshu.com/p/33ee5e7d312c
     https://www.it610.com/article/1408708687459090432.htm
     */
    
    // 对象释放的过程模拟如下：
//    id object_dispose(id obj)
//    {
//        if (!obj) return nil;
//
//        objc_destructInstance(obj);
//        free(obj);
//
//        return nil;
//    }
}

@end
