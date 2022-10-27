//
//  NSObject+AddMethod.m
//  OCTest

//  给分类添加方法

//  Created by xiaohui on 2018/3/15.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "NSObject+AddMethod.h"
#import <objc/runtime.h>

@implementation NSObject (AddMethod)

//字典转简单模型
+ (instancetype)simpleModelFromDictionary:(NSDictionary *)dictionary {
    id objc = [[self alloc] init];
    unsigned int count = 0;
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (NSInteger i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        //通过成员变量获取变量名
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //通过变量名取出与模型对应的的属性名，要从索引1开始取key, 否则会取到“_key“或者取不完整
        NSString *key = [ivarName substringFromIndex:1];
        id value = [dictionary objectForKey:key];
        //此处的判断是考虑了可能会出现模型中属性的数量大于字典中Key的数量的情况
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}

//字典转复杂模型（目标模型中包含了其他的模型）
+ (instancetype)modelInModelFromDictionary:(NSDictionary *)dictionary {
    id objc = [[self alloc] init];
    unsigned int count = 0;
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (NSInteger i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        //通过成员变量获取变量名
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //通过成员变量获取类型名
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        //通过变量名取出与模型对应的的属性名，要从索引1开始取key, 否则会取到“_key“或者取不完整
        NSString *key = [ivarName substringFromIndex:1];
        id value = [dictionary objectForKey:key];
        //判断是否是模型
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            //将字符串转化成对应的模型类
            Class modelClass = NSClassFromString(ivarType);
            if (modelClass) {
                //字典转模型
                value = [modelClass modelInModelFromDictionary:value];
//                value = [modelClass simpleModelFromDictionary:value];
            }
        }
        //此处的判断是考虑了可能会出现模型中属性的数量大于字典中Key的数量的情况
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}

//字典转复杂模型（目标模型中包含了包含其他模型的数组）
+ (instancetype)modelInArrayFromDictionary:(NSDictionary *)dictionary {
    id objc = [[self alloc] init];
    unsigned int count = 0;
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (NSInteger i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        //通过成员变量获取变量名
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //通过变量名取出与模型对应的的属性名，要从索引1开始取key, 否则会取到“_key“或者取不完整
        NSString *key = [ivarName substringFromIndex:1];
        id value = [dictionary objectForKey:key];
        //判断是否是数组类型
        if ([value isKindOfClass:[NSArray class]]) {
            //判断能否响应代理方法
            if ([self respondsToSelector:@selector(generateDictionaryWithModel)]) {
                //转换self
                id Self = self;
                //通过生成的字典取出对应key下的模型类名字符串
                NSString *classType = [Self generateDictionaryWithModel][key];
                //将字符串转化成对应的模型类
                Class modelClass = NSClassFromString(classType);
                NSMutableArray *modelArray = [NSMutableArray array];
                //遍历数组中的字典
                for (NSDictionary *dic in value) {
                    //字典转模型
                    id model = [modelClass modelInArrayFromDictionary:dic];
//                    id model = [modelClass simpleModelFromDictionary:dic];
                    [modelArray addObject:model];
                }
                value = modelArray;
            }
        }
        //此处的判断是考虑了可能会出现模型中属性的数量大于字典中Key的数量的情况
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}

//通用的转化方法
+ (instancetype)modelFromDictionary:(NSDictionary *)dictionary {
    id objc = [[self alloc] init];
    unsigned int count = 0;
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (NSInteger i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        //通过成员变量获取变量名
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //通过变量名取出与模型对应的的属性名，要从索引1开始取key, 否则会取到“_key“或者取不完整
        NSString *key = [ivarName substringFromIndex:1];
        id value = [dictionary objectForKey:key];
        
        //通过成员变量获取类型名
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        //判断是否是模型
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            //将字符串转化成对应的模型类
            Class modelClass = NSClassFromString(ivarType);
            if (modelClass) {
                //字典转模型
                value = [modelClass modelInModelFromDictionary:value];
//                value = [modelClass simpleModelFromDictionary:value];
            }
        }
        
        //判断是否是数组类型
        if ([value isKindOfClass:[NSArray class]]) {
            //判断能否响应代理方法
            if ([self respondsToSelector:@selector(generateDictionaryWithModel)]) {
                //转换self
                id Self = self;
                //通过生成的字典取出对应key下的模型类名字符串
                NSString *classType = [Self generateDictionaryWithModel][key];
                //将字符串转化成对应的模型类
                Class modelClass = NSClassFromString(classType);
                NSMutableArray *modelArray = [NSMutableArray array];
                //遍历数组中的字典
                for (NSDictionary *dic in value) {
                    //字典转模型
                    id model = [modelClass modelInArrayFromDictionary:dic];
//                    id model = [modelClass simpleModelFromDictionary:dic];
                    [modelArray addObject:model];
                }
                value = modelArray;
            }
        }
        //此处的判断是考虑了可能会出现模型中属性的数量大于字典中Key的数量的情况
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}

@end
