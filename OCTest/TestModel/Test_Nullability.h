//
//  Test_Nullability.h
//  OCTest

//  为空性

//  Created by xiaohui on 2018/2/5.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

/**
 
 1.对属性、方法返回值、方法参数的修饰，使用：nonnull/nullable；
 2.对C函数的参数、Block返回值、Block参数的修饰，使用：_Nonnull/_Nullable，建议弃用：__nonnull/__nullable；
 
 **/

typedef void (^TestBlock)(BOOL b);

@interface Test_Nullability : NSObject

- (nullable instancetype)init1WithCompletionBlock:(TestBlock _Nullable)block;

- (nullable instancetype)init2WithCompletionBlock:(void (^ _Nullable)(BOOL b))block;

- (nullable instancetype)init3WithCompletionBlock:(void (^ _Nullable)(NSString * _Nullable str))block;

- (nullable instancetype)init4WithCompletionBlock:(id _Nullable (^ _Nullable)(NSString * _Nullable str))block;

- (void)test1WithCompletionBlock:(void (^ _Nullable)(BOOL b))block;

- (void)test2WithCompletionBlock:(void (^ _Nullable)(NSString * _Nullable str))block;

@end

/**
 
为了防止写一大堆nonnull，Foundation提供了一对儿宏，使得包在里面的对象会默认加上 nonnull 修饰符，只需把 nullable 的指出来就行；
 
 **/

NS_ASSUME_NONNULL_BEGIN
@interface Member : NSObject

@property (nonatomic, copy) NSString *id;//不可为空
@property (nonatomic, copy, nullable) NSString *name;//可为空
@property (nonatomic, assign) NSInteger age;

@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
@interface Team : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;//不可用

- (instancetype)initWithMember:(Member *)member NS_DESIGNATED_INITIALIZER;//（指定初始化器/指定构造器）

@property (nonatomic, readonly, strong) Member *member;//不可为空
@property (nonatomic, readonly, copy) NSArray<__kindof Member *> *members;

- (void)updateTeamData:(void (^ _Nullable)(NSError * _Nullable error))block;

@end
NS_ASSUME_NONNULL_END
