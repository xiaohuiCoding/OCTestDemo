//
//  TestVC8.m
//  OCTest

//  Block

//  Created by xiaohui on 2018/3/1.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

/* Block的本质：https://www.jianshu.com/p/4e79e9a0dd82 */

#import "TestVC8.h"
#import "CustomViewController.h"

//Block作为一个typedef
typedef void (^ABlock)(void);
ABlock b = ^void (void) {

};

@interface TestVC8 ()

@property (nonatomic, copy, nullable) void (^Block)(void); //Block作为一个属性

- (void)testBlock:(void (^)(void))block; //Block作为方法的参数

@end

@implementation TestVC8

- (void)testBlock:(void (^)(void))block {
    block();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //Block的标准模板
    /*** http://fuckingblocksyntax.com/ ***/
    
    //Block的实践
    /*** https://hit-alibaba.github.io/interview/iOS/ObjC-Basic/Block.html ***/
    
    
    
    //Block作为一个局部变量(从这里可以看出Block其实是一个匿名函数)
    void (^Block)(void) = ^void (void) {
        
    };
    Block();
    
    //Block作为一个函数的调用参数
    [self testBlock:^{
        
    }];
    

    
    [self test0];
    [self test1];
    [self test2];
}

//Block的返回值和参数
- (void)test0
{
    //有个疑问？？？--- 2 和 4 的返回值不能为 NSInteger...
    
    //1.无参无返回值
    void (^MyBlock1)(void) = ^{
        NSLog(@"无参无返回值的Block");
    };
    MyBlock1();
    
    //2.无参有返回值
    int (^MyBlock2)(void) = ^{
        return 1;
    };
    int a = MyBlock2();
    NSLog(@"a = %d",a);
    
    //3.有参无返回值
    void (^MyBlock3)(NSInteger) = ^(NSInteger p){
        NSLog(@"有参无返回值的Block");
    };
    MyBlock3(1);
    
    //4.有参有返回值
    NSInteger (^MyBlock4)(NSInteger) = ^(NSInteger p){
        return p;
    };
    NSInteger b = MyBlock4(1);
    NSLog(@"b = %ld",b);
}

//Block可以捕获来自外部作用域的变量，这是Block一个很强大的特性；通常外部变量是不能被修改的，如果想要修改，需要使用__block来声明；
- (void)test1
{
    //基本数据类型
    __block NSInteger i = 1;
    void (^MyBlock)(void) = ^{
        i++;
    };
    MyBlock();
    NSLog(@"i = %ld",i);
    
    //对象类型
    __block NSString *s = @"he";
    void (^MyBlock3)(void) = ^{
        s = [s stringByAppendingString:@"llo"];
    };
    MyBlock3();
    NSLog(@"s = %@",s);
}

//对于id类型的变量，在MRC下，使用 __block id x 不会retain变量，而在 ARC 下则会对变量进行retain（即和其他捕获的变量相同）。如果不想在block中进行retain可以使用 __unsafe_unretained __block id x，不过这样可能会导致野指针出现。更好的办法是使用 __weak 的临时变量 或者 把使用 __block 修饰的变量设为nil，以打破引用循环；
- (void)test2
{
    CustomViewController *vc = [[CustomViewController alloc] init];
    CustomViewController *__weak weakVC = vc;
    vc.TestBlock =  ^{
        [weakVC dismissViewControllerAnimated:YES completion:nil];
    };
    
//    CustomViewController * __block vc = [[CustomViewController alloc] init];
//    vc.TestBlock =  ^{
//        [vc dismissViewControllerAnimated:YES completion:nil];
//        vc = nil;
//    };
}

@end
