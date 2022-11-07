//
//  XHoperation.h
//  OCTest

// 自定义操作类可取消正在执行的任务

//  Created by apple on 2022/11/3.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHoperation : NSOperation

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) void (^finishedHandler)(UIImage *image);

@end

NS_ASSUME_NONNULL_END
