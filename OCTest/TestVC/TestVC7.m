//
//  TestVC7.m
//  OCTest

//  UIView的生命周期

//  Created by xiaohui on 2018/2/10.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC7.h"
#import "UIImage+PureColor.h"
#import "UIButton+AddResponseArea.h"
#import "UIImageView+RoundedCorner.h"
#import "TestView.h"
#import "NSString+Attributed.h"
#import "MosaicHandler.h"

@interface TestVC7 ()

@property (nonatomic, strong) UIImageView *mosaicImageView2;

@end

@implementation TestVC7

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 一些UI控件可以直接设置圆角，如：UIView，UITextField、UITextView、UILabel，但在设置背景色上，UILabel需要注意一下，不要直接设置label.backgroundColor，而是设置label.layer.backgroundColor
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 90, 100, 50)];
    view.backgroundColor = [UIColor cyanColor];
    view.layer.cornerRadius = 15;
//    view.layer.masksToBounds = NO;//默认是NO，如果设置为YES，会造成不必要的离屏渲染。
    [self.view addSubview:view];
    
    
    // 扩大按钮的响应区域
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 150, 100, 100);
//    [btn setBackgroundColor:[UIColor redColor]];
    [btn setImage:[UIImage drawImageWithSize:btn.frame.size color:[UIColor redColor] cornerRadius:15] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    [btn addInsets:UIEdgeInsetsMake(-5, -10, -15, -25)];
//    btn.contentEdgeInsets = UIEdgeInsetsMake(-5, -10, -15, -25);
    [self.view addSubview:btn];
    

    // 给图片画圆角
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 150, 100, 100)];
//    [imgView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fish" ofType:@"png"]]];
    [imgView setImage:[UIImage drawImageWithSize:imgView.frame.size color:[UIColor blueColor] cornerRadius:50]];
    [imgView drawRoundedCornerWithCornerRadius:50];
    [self.view addSubview:imgView];
    
    
    // 子视图部分超出父视图，仍可响应事件
//    TestView *testView = [[TestView alloc] initWithFrame:CGRectMake(80, 300, 120, 80)];
//    testView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:testView];
//
//    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    testBtn.frame = CGRectMake(20, -20, 80, 120);
//    [testBtn setBackgroundColor:[UIColor blueColor]];
//    [testBtn addTarget:self action:@selector(test2) forControlEvents:UIControlEventTouchUpInside];
//    [testView addSubview:testBtn];
    
    
    // 设置富文本样式（链式调用法）
    UILabel *testLabel = [[UILabel alloc] init];
    testLabel.backgroundColor = UIColor.lightGrayColor;
    testLabel.textColor = UIColor.grayColor; // 如果后面设置了foregroundColor则此句代码无效
    testLabel.numberOfLines = 0;
//    testLabel.numberOfLines = 2;
    [self.view addSubview:testLabel];
    [testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(imgView.mas_bottom).offset(20);
    }];
    // 段落样式（文案中要包含 \n 换行符，此时设置段落样式才会生效！）
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6.0; // 行间距
    paragraphStyle.paragraphSpacing = 26.0; // 段落间距
    paragraphStyle.alignment = NSTextAlignmentLeft;
//    paragraphStyle.firstLineHeadIndent = 28.0; // 首行缩进距离
//    paragraphStyle.headIndent = 10.0; // 头缩进
//    paragraphStyle.tailIndent = -10.0; // 尾缩进
    // 参考：https://www.jianshu.com/p/8d30b939f30b
    // 字符截断类型：换行时保证行尾字或词的完整 1.行尾是纯中文时不会出现半个中文 2.中、英、数字混合在一起时，连续的英文字母、数字不会被分隔开，如：哈哈abcd，结果：哈哈 或 哈哈abcd 如：哈哈1234，结果：哈哈 或 哈哈1234
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    // 设置为中间截断，如：abcd...hijk，需要截断时numberOfLines不能设置为0，否则文案会全部展示，截断无效
//    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingMiddle;
    testLabel.attributedText = [@"富文本测试abcdefghijklmnopqrstuvwxyz哈测试测试富文本哈哈1234哈测试测试测试\n富文本测试测试测试people富文本测试测试测试富文本测试测试测试horse" addAttributes:^(AttributedMaker * _Nonnull make) {
        make.font([UIFont systemFontOfSize:22.0]);
        make.paragraphStyle(paragraphStyle);
        make.foregroundColor(UIColor.whiteColor);
        make.backgroundColor(UIColor.blackColor);
    }];
    
    
    // 给图片添加马赛克效果
    UIImageView *mosaicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 460, (self.view.bounds.size.width-30)/2, 300)];
    mosaicImageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"girl" ofType:@"jpg"]];
    [mosaicImageView setImage:image];
    [self.view addSubview:mosaicImageView];
    self.mosaicImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-30)/2+20, 460, (self.view.bounds.size.width-30)/2, 300)];
    self.mosaicImageView2.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.mosaicImageView2];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 770, self.view.bounds.size.width-200, 30);
    [btn2 setBackgroundColor:[UIColor lightGrayColor]];
    [btn2 setTitle:@"一键马赛克" forState:UIControlStateNormal];
    [btn2 setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(test3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)test1 {
    NSLog(@"test1--->button is clicked!");
}

- (void)test2 {
    NSLog(@"test2--->button is clicked!");
}

- (void)test3:(UIButton *)sender {
    NSLog(@"test3--->button is clicked!");
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [sender setTitle:@"再来一次吧" forState:UIControlStateNormal];
        UIImage *image2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"girl" ofType:@"jpg"]];
        UIImage *mosaicImage = [MosaicHandler transToMosaicImage:image2 blockLevel:20];
        [self.mosaicImageView2 setImage:mosaicImage];
    } else {
        [sender setTitle:@"一键马赛克" forState:UIControlStateNormal];
        [self.mosaicImageView2 setImage:nil];
    }
}

@end
