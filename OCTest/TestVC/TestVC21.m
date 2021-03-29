//
//  TestVC21.m
//  OCTest
//
//  Created by aladin on 2019/3/1.
//  Copyright © 2019 XIAOHUI. All rights reserved.
//

#import "TestVC21.h"
#import "SBBreathLightView.h"

@interface TestVC21 ()<CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) CAAnimationGroup *groups;

@property (nonatomic, strong) SBBreathLightView *breathLightView;
@property (nonatomic, strong) SBBreathLightView *breathLightView2;
@property (nonatomic, strong) SBBreathLightView *breathLightView3;

@end

@implementation TestVC21

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.purpleColor;
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _imgView.center = self.view.center;
    _imgView.image = [UIImage imageNamed:@"one"];
    [self.view addSubview:_imgView];

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(300, 100, 60, 60)];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    OTWeakSelf;
    [self.view addSubview:self.breathLightView];
    self.breathLightView.clickHandler = ^{
        OTStrongSelf;
        [strongSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.breathLightView2];
    self.breathLightView2.clickHandler = ^{
        OTStrongSelf;
        [strongSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.breathLightView3];
    self.breathLightView3.clickHandler = ^{
        OTStrongSelf;
        [strongSelf.navigationController popViewControllerAnimated:YES];
    };
}

- (void)buttonClicked {
//    [self addPositionAnimation];
//    [self addTransformAnimation];
//    [self addScaleAnimation];
    [self addGroupAnimation];
}

//移动
- (void)addPositionAnimation
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.duration = 3;
    moveAnimation.repeatCount = 1;//重复次数，永久重复的话设置为HUGE_VALF
//    moveAnimation.beginTime = CACurrentMediaTime() + 0.5;//指定动画开始时间。从开始指定延迟几秒执行的话，需设置为「CACurrentMediaTime() + 秒数」的形式。
    moveAnimation.timingFunction =  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];//设定动画的速度变化
    moveAnimation.autoreverses = NO;//动画结束时是否执行逆动画
    moveAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 128)];//开始帧，一个点，绝对值
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 158)];//结束帧，一个点，绝对值
//    moveAnimation.byValue = [NSValue valueWithCGPoint:CGPointMake(0, 30)];//结束帧，一个点，相对值
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    [_imgView.layer addAnimation:moveAnimation forKey:nil];
//    [_imgView.layer addAnimation:moveAnimation forKey:@"move-layer"];//仅仅是一个标记，可为nil
}

//旋转
- (void)addTransformAnimation
{
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    transformAnimation.duration = 3;
    transformAnimation.repeatCount = 1;//重复次数，永久重复的话设置为HUGE_VALF
    //    transformAnimation.beginTime = CACurrentMediaTime() + 0.5;//指定动画开始时间。从开始指定延迟几秒执行的话，需设置为「CACurrentMediaTime() + 秒数」的形式。
    transformAnimation.timingFunction =  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];//设定动画的速度变化
    transformAnimation.autoreverses = NO;//动画结束时是否执行逆动画
    transformAnimation.fromValue = [NSNumber numberWithFloat:0];//开始帧，一个角度，绝对值
    transformAnimation.toValue = [NSNumber numberWithFloat:2*M_PI];//结束帧，一个角度，绝对值
//    transformAnimation.byValue = [NSNumber numberWithFloat:2*M_PI];//结束帧，一个角度，相对值
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.fillMode = kCAFillModeForwards;
    [_imgView.layer addAnimation:transformAnimation forKey:nil];
}

//缩放
- (void)addScaleAnimation
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 3;
    scaleAnimation.repeatCount = 1;//重复次数，永久重复的话设置为HUGE_VALF
    //    scaleAnimation.beginTime = CACurrentMediaTime() + 0.5;//指定动画开始时间。从开始指定延迟几秒执行的话，需设置为「CACurrentMediaTime() + 秒数」的形式。
    scaleAnimation.timingFunction =  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];//设定动画的速度变化
    scaleAnimation.autoreverses = NO;//动画结束时是否执行逆动画
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];//开始帧，一个倍率，绝对值
    scaleAnimation.toValue = [NSNumber numberWithFloat:2.0];//结束帧，一个倍率，绝对值
//    scaleAnimation.byValue = [NSNumber numberWithFloat:1.0];//结束帧，一个倍率，相对值
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [_imgView.layer addAnimation:scaleAnimation forKey:nil];
}

//动画组合
- (void)addGroupAnimation
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 158)];
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    transformAnimation.toValue = [NSNumber numberWithFloat:2*M_PI];
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[moveAnimation,transformAnimation,scaleAnimation];
    animationGroup.duration = 3.0;
    animationGroup.repeatCount = 1;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.delegate = self;
    [_imgView.layer addAnimation:animationGroup forKey:nil];
}

#pragma mark - CAAnimationDelegate

//动画开始
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"start!");
}

//动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"end!");
}

- (SBBreathLightView *)breathLightView {
    if (!_breathLightView) {
        _breathLightView = [[SBBreathLightView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//        _breathLightView.backgroundColor = UIColor.redColor;
        _breathLightView.center = self.view.center;
    }
    return _breathLightView;
}

- (SBBreathLightView *)breathLightView2 {
    if (!_breathLightView2) {
        _breathLightView2 = [[SBBreathLightView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//        _breathLightView.backgroundColor = UIColor.redColor;
        _breathLightView2.center = CGPointMake(self.view.center.x, self.view.center.y-100);
    }
    return _breathLightView2;
}

- (SBBreathLightView *)breathLightView3 {
    if (!_breathLightView3) {
        _breathLightView3 = [[SBBreathLightView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//        _breathLightView.backgroundColor = UIColor.redColor;
        _breathLightView3.center = CGPointMake(self.view.center.x, self.view.center.y+100);
    }
    return _breathLightView3;
}

@end
