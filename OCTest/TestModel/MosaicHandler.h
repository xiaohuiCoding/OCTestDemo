//
//  MosaicHandler.h
//  OCTest

//  图片打马赛克

//  Created by apple on 2022/10/26.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MosaicHandler : NSObject

+ (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level;

@end

NS_ASSUME_NONNULL_END
