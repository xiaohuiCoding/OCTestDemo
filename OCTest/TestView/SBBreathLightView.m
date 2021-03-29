//
//  SBBreathLightView.m
//  OCTest

//  呼吸灯

//  Created by Apple on 2021/3/29.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import "SBBreathLightView.h"

@interface SBBreathLightView ()

@property (nonatomic, strong) UIView *bkgView;
@property (nonatomic, strong) UIView *pointView;
@property (nonatomic, strong) UIButton *eventBtn;
@property (nonatomic, strong) CAAnimationGroup *animationGroup;

@end

@implementation SBBreathLightView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        [self.bkgView.layer addAnimation:self.animationGroup forKey:@"group"];
    }
    return self;
}

- (void)setupSubviews {
    [self addSubview:self.bkgView];
    [self addSubview:self.pointView];
    [self addSubview:self.eventBtn];
}

- (void)eventBtnClicked {
    if (self.clickHandler) {
        self.clickHandler();
    }
}

#pragma mark - lazy loading

- (UIView *)bkgView {
    if (!_bkgView) {
        _bkgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        _bkgView.backgroundColor = OTHexA(0x000000, 0.4);
        _bkgView.layer.cornerRadius = 8;
        _bkgView.layer.masksToBounds = YES;
        _bkgView.center = self.center;
    }
    return _bkgView;
}

- (UIView *)pointView {
    if (!_pointView) {
        _pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
        _pointView.backgroundColor = UIColor.whiteColor;
        _pointView.layer.cornerRadius = 3;
        _pointView.layer.masksToBounds = YES;
        _pointView.center = self.center;
    }
    return _pointView;
}

- (UIButton *)eventBtn {
    if (!_eventBtn) {
        _eventBtn = [[UIButton alloc] initWithFrame:self.bounds];
        _eventBtn.backgroundColor = UIColor.clearColor;
        [_eventBtn addTarget:self action:@selector(eventBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eventBtn;
}

- (CAAnimationGroup *)animationGroup {
    if (!_animationGroup) {
        // 缩放
        CABasicAnimation *scale = [CABasicAnimation animation];
        scale.keyPath = @"transform.scale";
        scale.fromValue = @1;
        scale.toValue = @0.5;
        scale.duration = 0.75;
        [scale setBeginTime:0];

        // 透明度
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacity.fromValue = @1.0;
        opacity.toValue = @0.8;
        opacity.duration = 0.75;
        [opacity setBeginTime:0];

        // 缩放
        CABasicAnimation *scale2 = [CABasicAnimation animation];
        scale2.keyPath = @"transform.scale";
        scale2.fromValue = @0.5;
        scale2.toValue = @1;
        scale2.duration = 0.75;
        [scale2 setBeginTime:0.75];

        // 透明度
        CABasicAnimation *opacity2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacity2.fromValue = @0.8;
        opacity2.toValue = @1.0;
        opacity2.duration = 0.75;
        [opacity2 setBeginTime:0.75];

        // 动画组(可设置开始时间，进而设置动画的执行顺序)
        _animationGroup = [CAAnimationGroup animation];
        _animationGroup.animations = @[scale,opacity,scale2,opacity2];
        _animationGroup.removedOnCompletion = NO;
        _animationGroup.fillMode = kCAFillModeForwards;
        _animationGroup.duration = 1.5;
        _animationGroup.repeatCount = FLT_MAX;
    }
    return _animationGroup;
}

@end
