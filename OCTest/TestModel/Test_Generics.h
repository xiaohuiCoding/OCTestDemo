//
//  Test_Generics.h
//  OCTest

//  泛型（自定义泛型类）

//  Created by xiaohui on 2018/1/31.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 1.可以加类型限制，如： ObjectType ，它是传入类型的 placeholder，它只能在 @interface 上定义（类声明、类扩展、Category），如果你喜欢用 T 表示也 ok，这个类型在 @interface 和 @end 区间的作用域有效，可以把它作为入参、出参、甚至内部 NSArray 属性的泛型类型，应该说一切都是符合预期的。
 
 2.不指定泛型类型的 Stack 可以和任意泛型类型转化，但指定了泛型类型后，两个不同类型间是不可以强转的，假如你希望主动控制转化关系，就需要使用泛型的协变性和逆变性修饰符了：
 
 __covariant - 协变性，子类型可以强转到父类型（里氏替换原则）
 __contravariant - 逆变性，父类型可以强转到子类型
 
 **/
 
@interface Test_Generics<__covariant ObjectType> : NSObject
//@interface Test_Generics<__contravariant ObjectType> : NSObject

@property (nonatomic, readonly) NSInteger type;

- (void)test_GenericsLog:(ObjectType)obj;

@end

//@interface Test_Generics<ObjectType: NSNumber *> : NSObject
//
//@end
//
//@interface Test_Generics<ObjectType: id<NSCopying>> : NSObject
//
//@end



@interface A : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end

@protocol A

@end



@interface B : NSObject

@property (nonatomic, strong) NSArray<A> *array;

@end

