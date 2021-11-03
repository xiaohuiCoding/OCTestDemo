//
//  SafeMutableArray.h
//  OCTest

//  实现一个线程安全的数组

//  Created by Apple on 2021/11/3.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SafeMutableArray<ObjectType> : NSMutableArray

@end

NS_ASSUME_NONNULL_END
