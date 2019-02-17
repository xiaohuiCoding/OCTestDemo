//
//  TestVC13.m
//  OCTest

//  Runtime的应用（三）

//  Created by xiaohui on 2018/3/16.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC13.h"
#import <objc/runtime.h>

@interface TestVC13 ()

@end

@implementation TestVC13

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self printClassInfoWithClassName:@"MobClickApp"];
    
//    [self printAllClassInProject];
    
    [self printAllClassWithoutSystemInProject];
}

//获取某个类的信息，包含属性、方法和协议
- (void)printClassInfoWithClassName:(NSString *)className {
    Class cls = NSClassFromString(className);
    [self printPropertyListWithClass:cls];
    [self printMethodListWithClass:cls];
    [self printProtocolListWithClass:cls];
}

- (void)printPropertyListWithClass:(Class)class {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(class, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"ivar[%d] --- %s : %s",i,ivarName,type);
    }
    free(ivarList);
}

- (void)printMethodListWithClass:(Class)class {
    unsigned int count = 0;
    Method *instanceMethodList = class_copyMethodList(class, &count);
    for (int i = 0; i < count; i++) {
        Method method = instanceMethodList[i];
        SEL sel = method_getName(method);
        NSString *methodName = NSStringFromSelector(sel);
        NSLog(@"instance method[%d] --- %@",i,methodName);
    }
    free(instanceMethodList);
    
    const char *clsName = class_getName(class);
    Class metaClass = objc_getMetaClass(clsName);
    Method *classMethodList = class_copyMethodList(metaClass, &count);
    for (int i = 0; i < count; i++) {
        Method method = classMethodList[i];
        SEL sel = method_getName(method);
        NSString *methodName = NSStringFromSelector(sel);
        NSLog(@"class method[%d] --- %@",i,methodName);
    }
    free(classMethodList);
}

- (void)printProtocolListWithClass:(Class)class {
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &count);
    for (int i = 0; i < count; i++) {
        Protocol *protocol = protocolList[i];
        const char *name = protocol_getName(protocol);
        NSLog(@"protocol[%d] --- %s",i,name);
    }
    free(protocolList);
}

// 获取项目中所有已注册的类，包含系统的和非系统的
- (void)printAllClassInProject {
    unsigned int count = 0;
    Class *classList = objc_copyClassList(&count);
    for (int i = 0; i < count; i++) {
        Class cls = classList[i];
        NSString *className = NSStringFromClass(cls);
        NSLog(@"every class in project --- %@",className);
    }
    free(classList);
}

// 获取项目中所有非系统的类
- (void)printAllClassWithoutSystemInProject {
    unsigned int count = 0;
    // 用 executablePath 获取当前 app image
    NSString *appImage = [[NSBundle mainBundle] executablePath];
    // objc_copyClassNamesForImage 获取到的是 image 下的类，直接排除了系统的类
    const char **classNames = objc_copyClassNamesForImage([appImage UTF8String], &count);
    if (classNames) {
        NSMutableArray *classNameStringArray = [NSMutableArray array];
        for (unsigned int i = 0; i < count; i++) {
            const char *className = classNames[i];
            NSString *classNameString = [NSString stringWithUTF8String:className];
            [classNameStringArray addObject:classNameString];
        }
        NSArray *allClassNames = [classNameStringArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        NSLog(@"external classes in project --- %@",allClassNames);
    }
    free(classNames);
}

@end
