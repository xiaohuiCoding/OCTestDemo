//
//  ViewController.m
//  OCTest

//  加载 Main.storyboard 的方式创建根视图

//  Created by xiaohui on 2018/1/31.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "ViewController.h"

#define kScreenSize [UIScreen mainScreen].bounds.size

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.tableView];
    
    [self addSubviews];//构建子视图应该在loadView执行后进行
    
    self.dataSource = @[@"Deep copy / Shallow copy",
                        @"weak / strong / copy",
                        @"Nullability",
                        @"Generics",
                        @"__kindof",
                        @"Hash / Equal",
                        @"UIViewController's life cycle",
                        @"UIView's life cycle"];
    
    self.navigationItem.title = [NSString stringWithFormat:@"Objective-C(%ld条)",(unsigned long)self.dataSource.count];
}

- (void)addSubviews {
    //...
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
    cell.textLabel.text = [NSString stringWithFormat:@"%ld.%@",(long)indexPath.row,self.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = [NSString stringWithFormat:@"TestVC%ld",(long)indexPath.row];
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    vc.navigationItem.title = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy loading

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width,kScreenSize.height) style:UITableViewStyleGrouped];
        tempTableView.backgroundColor = [UIColor blueColor];//设置背景颜色有效，因为 在 -viewDidLoad 中 [self.view addSubview:self.tableView] 只是添加子视图，二者指向不同的内存地址
        tempTableView.showsVerticalScrollIndicator = NO;
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        [tempTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:tempTableView];//先创建临时变量添加到父视图上
        _tableView = tempTableView;//再赋值给弱引用属性，此处是浅拷贝，二者指向同一内存地址
    }
    return _tableView;
}

#pragma mark - other

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
