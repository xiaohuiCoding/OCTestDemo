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

/* Runtime，顾名思义，即运行时，区别于编译时。

 编译时：就是正在编译的时刻。而编译，就是编译器把源代码翻译成机器能识别的代码（实际上可能只是翻译成某个中间状态的语言）。编译时，做了一些检查、翻译的工作。会检查你的关键字、词法、语法，如果发现了错误，就会编译不通过，提示错误信息。这个过程也会进行静态类型分析，这时候只是扫描代码而已，并没有真正放到内存中运行，也不存在分配内存。
 
 运行时：将代码运行起来，装载到内存中去。而运行时做的类型检查跟编译时类型检查（静态类型检查）不一样，不是简单的扫描代码，会将其运行在内存中做些判断和操作。例如我们通过使用 performSelector 给对象发送执行方法选择器消息的方式，就是运行时的操作。
 
 高级编程语言想要成为可执行文件需要先编译为汇编语言再汇编为机器语言，机器语言也是计算机能够识别的唯一语言，但是OC并不能直接编译为汇编语言，而是要先转写为纯C语言再进行编译和汇编的操作，从OC到C语言的过渡就是由runtime来实现的。然而我们使用OC进行面向对象开发，而C语言更多的是面向过程开发，这就需要将面向对象的类转变为面向过程的结构体。

 参考：https://www.jianshu.com/p/6ebda3cd8052
 参考：https://www.jianshu.com/p/a8bcb2039d7d
 */

#import "TestVC11.h"
#import "RuntimeTestModel.h"
#import "ModelA.h"
#import "ModelB.h"
#import "NSArray+Description.h"
#import "RuntimeMsgModel.h"
#import "RuntimeMsgModel2.h"
#import <objc/message.h>

@interface TestVC11 ()

@end

@implementation TestVC11

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加断言
    NSAssert(self.view.subviews.count == 0, @"数组为空了");

    /* 一、验证发送消息机制的底层是 objc_msgSend(id _Nullable self, SEL _Nonnull op, ...)
    注意：
    1.调用objc_msgSend，需要导入头文件： #import <objc/message.h>;
    2.使用objc_msgSend时，编译器会报错，需要关闭编译期的严格检查机制；target —> Build Setting —> 搜索 "msgSend" —> Enable Strict Checking of objc_msgSend Calls 设置为 NO;
     */
    RuntimeMsgModel *model = [[RuntimeMsgModel alloc] init];
    [model test];
    objc_msgSend(model, @selector(test));
    
    /*
     二、RuntimeMsgModel2 继承自 RuntimeMsgModel，RuntimeMsgModel2并没有实现test方法，却依然可以调用成功，没有报 "unrecognized selector sent to instance 0x600000548280"的错误！神奇～
     */
    RuntimeMsgModel2 *model2 = [[RuntimeMsgModel2 alloc] init];
    [model2 test];
    objc_msgSend(model2, @selector(test));
    
    /* 另外，直接直接调用底层C的API -> objc_msgSendSuper() 函数也是可以调成功的！
     
     可见，如果一个类继承自另一个类，这个类没有实现和父类同名的某个方法，调用后却没有崩溃，可以猜想是因为其父类实现了这个方法。
     所以可以继续猜想，类的实例方法的调用是会像父类查找。而方法的本质是 objc_msgSend 发送消息，那么它是怎么通过 sel 找到 imp 函数地址的指针 ，从而找到函数的具体实现呢？核心技术：地址偏移～
     参考： https://www.jianshu.com/p/58f608f4caac
     */
    struct objc_super model2Super;
    model2Super.receiver = model2;
    model2Super.super_class = [RuntimeMsgModel class];
    objc_msgSendSuper(&model2Super, sel_registerName("test"));
    
    
    /*
     下面是runtime的一些具体应用
     */
    RuntimeTestModel *testModel = [[RuntimeTestModel alloc] init];
    [testModel test1];
    [testModel test2];
    
    ModelA *modelA = [[ModelA alloc] init];
    [modelA test];
    
    ModelB *modelB = [[ModelB alloc] init];
    [modelB test];
    
    // 打印包含中文的数组内容，请显式输出中文，不要输出UTF-8的格式
    NSArray *array = @[@"小辉",@"abc",@"123"];
    NSLog(@"打印数组 --- %@",array);
}

@end
