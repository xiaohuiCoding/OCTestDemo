//
//  XHOperation.h
//  OCTest
//
//  Created by apple on 2022/11/15.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHOperation : NSOperation

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) void (^finishedHandler)(UIImage *image);

@end

NS_ASSUME_NONNULL_END
