//
//  Girl.h
//  OCTest
//
//  Created by xiaohui on 2018/6/6.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Boy.h"
@class Boy;

@interface Girl : NSObject

@property (nonatomic, strong) Boy *boy;

@end

/**
 
 以下两种情况不能使用@class:
 1.新的类继承某个父类，需要引用父类的头文件，Xcode在新建类的时候会帮你自动引入父类的头文件，此种情况我们不必过多的关注。
 2.要声明的类须遵守某种协议（protocol），需引入该协议的头文件。（此时应尽量把协议单独写一个文件，委托协议除外）
 
 **/
