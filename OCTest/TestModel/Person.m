//
//  Person.m
//  OCTest
//
//  Created by xiaohui on 2018/2/1.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "Person.h"

@interface Person ()

@end

@implementation Person

- (void)testBlock {
    void (^block)(void) = ^{
//        NSLog(@"Person --- self.name = %@",self.name); // 查看源码得知：self.name调用了get方法，通过方法选择器获取
//        NSLog(@"Person _name = %@",_name); // 查看源码得知：_name通过地址直接获取
    };
    block();
     
    /*
     1.查看block对象的继承链，可以看出各级的类型；
     2.从打印的结果可以看出block最终都是继承自NSBlock类型，而NSBlock继承于NSObjcet；
     3.block其中的isa指针其实是来自NSObject中的，这也更加印证了block的本质其实就是OC对象；
     */
    
    NSLog(@"%@", [block class]); // 若block中没有捕获变量：__NSGlobalBlock__；若block中捕获了变量：__NSMallocBlock__
    NSLog(@"%@", [[block class] superclass]); // NSBlock
    NSLog(@"%@", [[[block class] superclass] superclass]); // NSObject
    NSLog(@"%@", [[[[block class] superclass] superclass] superclass]); // null
    
    // 1. 内部没有调用外部变量的block
    void (^block1)(void) = ^{
        NSLog(@"");
    };
    NSLog(@"第一种 %@", [block1 class]); // __NSGlobalBlock__
    
    // 2. 内部调用外部变量的block
    int num = 10;
    void (^block2)(void) = ^{
        NSLog(@"%d",num);
    };
    NSLog(@"第二种 %@", [block2 class]); // __NSMallocBlock__
    
    // 3. 直接调用的block
     NSLog(@"第三种 %@", [^{
         NSLog(@"%d",num);
     } class]);                        // __NSStackBlock__
}

- (Person *)initWithName:(NSString *)name gender:(NSString *)gender {
    if (self = [super init]) {
        self.name  = name;
        self.gender = gender;
    }
    return self;
}

+ (Person *)personWithName:(NSString *)name gender:(NSString *)gender {
    return [[self alloc] initWithName:name gender:gender];
}

- (Person *)copyWithZone:(NSZone *)zone {
    Person *person = [[Person allocWithZone:zone] init];
    person.name = [self.name copyWithZone:zone];
    person.gender = [self.gender copyWithZone:zone];
    return person;
}

- (Person *)mutableCopyWithZone:(NSZone *)zone {
    Person *person = [[Person allocWithZone:zone] init];
    person.name = [self.name mutableCopyWithZone:zone];
    person.gender = [self.gender mutableCopyWithZone:zone];
    return person;
}

- (NSUInteger)hash {
    return [self.name hash] ^ [self.gender hash];
}

@end
