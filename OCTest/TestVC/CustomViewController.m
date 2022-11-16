//
//  CustomViewController.m
//  OCTest

//  编码的方式创建根视图

//  Created by xiaohui on 2018/2/11.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "CustomViewController.h"

#define kScreenSize [UIScreen mainScreen].bounds.size

@interface CustomViewController () <UITableViewDataSource, UITableViewDelegate>

//@property (nonatomic, weak) UITableView *tableView;//建议用weak声明（不过也因情况而定吧，可能会导致视图获取失败，目前尚有争议！）
@property (nonatomic, strong) UITableView *tableView;//用strong声明也不会出错（由于strong是强引用，又是用懒加载构建，可能会导致在某些需求下无法重新构建该视图！）

@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation CustomViewController

//loadView应该在开发者自行通过编码而不应该在通过Interface Builder定制view时被实现，更不应该在方法中调用[super loadView]，方法中应该有self.view = xxx 这样的行为

- (void)loadView {
    
    //如果属性tableView是用weak声明的就要调用这句，因为此时view是nil，会导致无限循环调用此-loadView方法，最终导致self.view的页面空白或程序异常
    
//    [super loadView];

//    NSLog(@"%s",__func__);
    self.view = self.tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"%s",__func__);

    self.view.backgroundColor = UIColor.whiteColor;

    self.dataSource = @[@" 0.Deep copy / Shallow copy",
                        @" 1.weak / strong / copy",
                        @" 2.Nullability",
                        @" 3.Generics",
                        @" 4.Some interview topic",
                        @" 5.Hash and Equal",
                        @" 6.CADisplayLink",
                        @" 7.UIView's life cycle",
                        @" 8.Block",
                        @" 9.RunLoop and performSelector",
                        @"10.RunLoop and thread",
                        @"11.Runtime（一）",
                        @"12.Runtime（二）",
                        @"13.Runtime（三）",
                        @"14.@autoreleasepool",
                        @"15.GCD",
                        @"16.NSThread（一）",
                        @"17.NSThread（二）",
                        @"18.NSThread（三）",
                        @"19.NSOperation and NSOperationQueue",
                        @"20.Queue",
                        @"21.CABasicAnimation",
                        @"22.CATransform3D",
                        @"23.KVO",
                        @"24.ReactiveCocoa",
                        @"25.InterView",
                        @"26.NSTimer",
                        @"27.Crash（一）",
                        @"28.Crash（二）",
                        @"29.Crash（三）",
                        @"30.UITableView 优化",
                        @"31.WKWebView 进阶",
                        @"32.高阶容器",
                        @"33.内存管理",
                        @"34.KVC",
                        @"35.逆向 混淆",
                        @"36.组件化",
                        @"37.数据库"
                        ];

    self.navigationItem.title = [NSString stringWithFormat:@"Objective-C(%ld)",(unsigned long)self.dataSource.count];
}

#pragma mark - DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.row < self.dataSource.count) {
        NSString *txt = self.dataSource[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.text = txt;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = [NSString stringWithFormat:@"TestVC%ld",(long)indexPath.row];
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    vc.navigationItem.title = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy loading

//弱引用时的懒加载
//- (UITableView *)tableView {
//    if (!_tableView) {
//        UITableView *tempTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
//        tempTableView.backgroundColor = [UIColor blueColor];//设置背景颜色无效，因为 在 -loadView 中 self.view = self.tableView 属于浅拷贝，二者指向同一内存地址
//        tempTableView.showsVerticalScrollIndicator = NO;
//        tempTableView.delegate = self;
//        tempTableView.dataSource = self;
//        [tempTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//        [self.view addSubview:tempTableView];//先创建临时变量添加到父视图上
//        _tableView = tempTableView;//再赋值给弱引用属性，此处是浅拷贝，二者指向同一内存地址
//    }
//    return _tableView;
//}

//强引用时的懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor blueColor];//设置背景颜色无效，因为 在 -loadView 中 self.view = self.tableView 属于浅拷贝，二者指向同一内存地址
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end
