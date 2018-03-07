//
//  UIImage+PureColor.m
//  OCTest

//  绘制纯色图片

//  Created by xiaohui on 2018/3/7.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "UIImage+PureColor.h"

@implementation UIImage (PureColor)

+ (UIImage *)drawImageWithSize:(CGSize)size color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = color;
    view.layer.cornerRadius = cornerRadius;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);//参数的含义：区域大小、半透明效果、屏幕密度
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
