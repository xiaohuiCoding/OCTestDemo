//
//  UIImage+PureColor.h
//  OCTest

//  绘制纯色图片

//  Created by xiaohui on 2018/3/7.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PureColor)

+ (UIImage *)drawImageWithSize:(CGSize)size color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

@end
