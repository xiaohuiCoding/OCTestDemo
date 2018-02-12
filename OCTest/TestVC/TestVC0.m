//
//  TestVC0.m
//  OCTest

//  深浅拷贝

//  Created by xiaohui on 2018/2/10.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC0.h"

@interface TestVC0 ()

@end

@implementation TestVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //深拷贝与浅拷贝
    
    /***** 1.NSString ******/
    
//      NSString *strSource = @"abc";
//      NSString *strDest = strSource;//直接赋值，内部执行浅拷贝，等同于copy
//      strSource = @"aaa";
//      strDest = @"bbb";
//
//
//      NSString *strSource = @"abc";
//      NSString *strDest = [strSource copy];//内部执行浅拷贝
//      strSource = @"aaa";
//      strDest = @"bbb";
//
//
//      NSString *strSource = @"abc";
//      NSString *strDest = [strSource mutableCopy];//内部执行深拷贝
//      strSource = @"aaa";
//      strDest = @"bbb";
    
    
    
    /***** 2.NSMutableString ******/
    
//      NSMutableString *strSource = [[NSMutableString alloc] initWithString:@"abc"];
//      NSMutableString *strDest = strSource;//直接赋值，内部执行浅拷贝
//      [strSource appendString:@"d"];
//      [strDest appendString:@"e"];
//
//
//      NSMutableString *strSource = [[NSMutableString alloc] initWithString:@"abc"];
//      NSMutableString *strDest = [strSource copy];//内部执行深拷贝，strDest所属类型变成NSString了
//      [strSource appendString:@"d"];
//      //[strDest appendString:@"e"];//此句代码执行后程序会crash，因为此时strDest实际上已经变成不可变字符串了
//      strDest = @"bbb";//此句代码会报警告，实际上是没错误的！此时可直接赋值，内部执行深拷贝
//
//
//      NSMutableString *strSource = [[NSMutableString alloc] initWithString:@"abc"];
//      NSMutableString *strDest = [strSource mutableCopy];//内部执行深拷贝
//      [strSource appendString:@"d"];
//      [strDest appendString:@"e"];
    
    
    
    /***** 3.NSArray ******/
    
//      NSArray *array = @[@1,@2];
//      NSArray *newArray = array;//直接赋值，array和obj内部都执行浅拷贝，等同于copy
//
//
//      NSArray *array = @[@1,@2];
//      NSArray *newArray = [array copy];//array和obj内部都执行浅拷贝
//
//
//      NSArray *array = @[@1,@2];
//      NSArray *newArray = [array mutableCopy];//array内部执行深拷贝，obj内部执行浅拷贝
//
//
//    //完全深拷贝（array和array中的obj都执行深拷贝，此时，newArray无论是容器本身还是容器内部对象都和原来的array无关联）
//      NSArray *array = @[@1,@2];
//      NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
//      NSArray *newArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    
    
    /***** 4.NSMutableArray ******/
    
//      NSMutableArray *array = [NSMutableArray arrayWithObjects:@1,@2, nil];
//      NSMutableArray *newArray = array;//直接赋值，array和obj内部都执行浅拷贝
//
//
//      NSMutableArray *array = [NSMutableArray arrayWithObjects:@1,@2, nil];
//      NSMutableArray *newArray = [array copy];//array内部执行深拷贝，obj内部执行浅拷贝
//
//
//      NSMutableArray *array = [NSMutableArray arrayWithObjects:@1,@2, nil];
//      NSMutableArray *newArray = [array mutableCopy];//array内部执行深拷贝，obj内部执行浅拷贝
//
//
//    //完全深拷贝（array和array中的obj都执行深拷贝，此时，newArray无论是容器本身还是容器内部对象都和原来的array无关联）
//      NSMutableArray *array = [NSMutableArray arrayWithObjects:@1,@2, nil];
//      NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
//      NSMutableArray *newArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
