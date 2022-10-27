//
//  NSObject+AddMethod.h
//  OCTest

//  给分类添加方法

//  Created by xiaohui on 2018/3/15.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelDelegate <NSObject>

+ (NSDictionary *)generateDictionaryWithModel;

@end

@interface NSObject (AddMethod)

//字典转简单模型
+ (instancetype)simpleModelFromDictionary:(NSDictionary *)dictionary;

//字典转复杂模型（目标模型中包含了其他的模型）
+ (instancetype)modelInModelFromDictionary:(NSDictionary *)dictionary;

//字典转复杂模型（目标模型中包含了包含其他模型的数组）
+ (instancetype)modelInArrayFromDictionary:(NSDictionary *)dictionary;

//通用的转化方法
+ (instancetype)modelFromDictionary:(NSDictionary *)dictionary;

@end
