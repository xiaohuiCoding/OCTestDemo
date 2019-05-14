//
//  TestVC22.m
//  OCTest
//
//  Created by aladin on 2019/3/2.
//  Copyright © 2019 XIAOHUI. All rights reserved.
//

/*
 
 CA_EXTERN CATransform3D CATransform3DMakeRotation (CGFloat angle, CGFloat x, CGFloat y, CGFloat z)

 angle代表角度，x,y,z分别代表三个方向的坐标
 
*/

#import "TestVC22.h"

@interface TestVC22 ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *animateCube;

@end

@implementation TestVC22

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self addTestImgView];
    
    [self addCube];
}

- (void)addTestImgView
{
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 128, 100, 100)];
    _imgView.image = [UIImage imageNamed:@"one"];
    [self.view addSubview:_imgView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(300, 100, 60, 60)];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)addCube
{
//    CGRect targetBounds = (CGRect){CGPointZero,CGSizeMake(200, 200)};
    CGRect targetBounds = CGRectMake(0, 0, 200, 200);
    self.animateCube = [[UIView alloc] initWithFrame:targetBounds];
    self.animateCube.center = self.view.center;
    [self.view addSubview:self.animateCube];
    
    UIView *test0 = [[UIView alloc] initWithFrame:targetBounds];// front
    test0.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.25];
    test0.layer.transform = CATransform3DTranslate(test0.layer.transform, 0, 0, 100);
    
    UIView *test1 = [[UIView alloc] initWithFrame:targetBounds];// back
    test1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    test1.layer.transform = CATransform3DTranslate(test1.layer.transform, 0, 0, -100);
    
    UIView *test2 = [[UIView alloc] initWithFrame:targetBounds];// left
    test2.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    test2.layer.transform = CATransform3DTranslate(test2.layer.transform, -100, 0, 0);
    test2.layer.transform = CATransform3DRotate(test2.layer.transform, M_PI_2, 0, 1, 0);
    
    UIView *test3 = [[UIView alloc] initWithFrame:targetBounds];// right
    test3.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5];
    test3.layer.transform = CATransform3DTranslate(test3.layer.transform, 100, 0, 0);
    test3.layer.transform = CATransform3DRotate(test3.layer.transform, M_PI_2, 0, 1, 0);
    
    UIView *test4 = [[UIView alloc] initWithFrame:targetBounds];// head
    test4.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
    test4.layer.transform = CATransform3DTranslate(test4.layer.transform, 0, -100, 0);
    test4.layer.transform = CATransform3DRotate(test4.layer.transform, M_PI_2, -1, 0, 0);
    
    UIView *test5 = [[UIView alloc] initWithFrame:targetBounds];// foot
    test5.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    test5.layer.transform = CATransform3DTranslate(test5.layer.transform, 0, 100, 0);
    test5.layer.transform = CATransform3DRotate(test5.layer.transform, M_PI_2, 1, 0, 0);
    
    [self.animateCube addSubview:test0];
    [self.animateCube addSubview:test1];
    [self.animateCube addSubview:test2];
    [self.animateCube addSubview:test3];
    [self.animateCube addSubview:test4];
    [self.animateCube addSubview:test5];
    
    self.animateCube.transform = CGAffineTransformMakeScale(0.5, 0.5);//2D缩小一倍
    
    __block CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0/-500;//m34可改变透视关系
//    transform.m44 = 2;//3D缩小一倍，m44可控制整体缩放

    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectOffset(self.animateCube.frame, 0, -100);
    label.text = @"翻滚的立方体";
    [label sizeToFit];
    [self.view addSubview:label];
//    label.transform = CGAffineTransformMakeScale(1, -1);//文字会沿着Y轴倒过来展示
    
    
    self.animateCube.layer.sublayerTransform = transform;
    float angle = M_PI / 180;

    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0/60 repeats:YES block:^(NSTimer * _Nonnull timer) {
        transform = CATransform3DRotate(transform, angle, 1, 1, 0.5);
        self.animateCube.layer.sublayerTransform = transform;
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)buttonClicked
{
    [self add3DTransformAnimation];
}

- (void)add3DTransformAnimation
{
    CGFloat disZ = 200;//z轴
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/6, 0, 1, 0);
    CATransform3D transform = CATransform3DConcat(rotate, scale);
    _imgView.layer.transform = rotate;
    _imgView.layer.transform = transform;
    _imgView.layer.anchorPoint = CGPointMake(0, 0.5);
    
//    CATransform3DRotate(<#CATransform3D t#>, <#CGFloat angle#>, <#CGFloat x#>, <#CGFloat y#>, <#CGFloat z#>)
}

@end
