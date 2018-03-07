//
//  UIImageView+RoundedCorner.m
//  OCTest

//  贝塞尔曲线实现圆角

//  Created by xiaohui on 2018/3/7.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "UIImageView+RoundedCorner.h"

@implementation UIImageView (RoundedCorner)

- (UIImageView *)drawRoundedCornerWithCornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    self.layer.mask = shapeLayer;
    return self;
}

@end
