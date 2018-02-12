//
//  TestVC3.m
//  OCTest

//  泛型

//  Created by xiaohui on 2018/2/10.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC3.h"
#import "Test_Generics.h"
#import "Person.h"

@interface TestVC3 ()

@end

@implementation TestVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //自定义泛型类的使用
    Test_Generics *t = [[Test_Generics alloc] init];
    NSLog(@"t.type = %ld",t.type);
    Person *p = [[Person alloc] init];
    [t test_GenericsLog:p];
    
    
    
    Test_Generics *t1;
    Test_Generics<NSString *> *t2;
    Test_Generics<NSMutableString *> *t3;
    t1 = t2;
    t1 = t3;
    t2 = t3;//__covariant - 协变性，子类型可以强转到父类型（里氏替换原则）
//    t3 = t2;//__contravariant - 逆变性，父类型可以强转到子类型
    
    
    
    //可以指定容器类中对象的类型
    NSArray<NSString *> *stringArray = @[@"xiao",@"hui"];
    NSLog(@"stringArray.firstObject.length = %ld",stringArray.firstObject.length);//编码时自定提示length
    
    NSMutableArray<NSString *> *mutableStringArray = [NSMutableArray array];
    [mutableStringArray addObject:@"c"];//自动提示object的类型
    NSLog(@"mutableStringArray = %@",mutableStringArray);

    NSDictionary<NSString *, NSNumber *> *mapping = @{@"age":@24, @"height":@180};
    NSLog(@"mapping = %@",mapping);
}

@end
