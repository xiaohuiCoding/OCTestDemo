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
@property (nonatomic, strong) NSString *cellString;//故意这么声明，为了利用其“弊端”！

@end

@implementation CustomViewController

//loadView应该在开发者自行通过编码而不应该在通过Interface Builder定制view时被实现，更不应该在方法中调用[super loadView]，方法中应该有self.view = xxx 这样的行为

- (void)loadView {
    
    //如果属性tableView是用weak声明的就要调用这句，因为此时view是nil，会导致无限循环调用此-loadView方法，最终导致self.view的页面空白或程序异常
    
//    [super loadView];

    NSLog(@"%s",__func__);
    self.view = self.tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%s",__func__);

    self.dataSource = @[@"Deep copy / Shallow copy",
                        @"weak / strong / copy",
                        @"Nullability",
                        @"Generics",
                        @"Some interview topic",
                        @"Hash and  Equal",
                        @"UIViewController's life cycle",
                        @"UIView's life cycle",
                        @"Block",
                        @"RunLoop and performSelector",
                        @"RunLoop and thread",
                        @"Runtime（一）",
                        @"Runtime（二）",
                        @"Runtime（三）",
                        @"@autoreleasepool",
                        @"GCD",
                        @"NSThread（一）",
                        @"NSThread（二）",
                        @"NSThread（三）",
                        @"NSOperation and NSOperationQueue"];

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
     NSMutableString *contentString = [NSMutableString stringWithFormat:@"%ld. %@",(long)indexPath.row,self.dataSource[indexPath.row]];
    self.cellString = contentString;
    if (indexPath.row <= 9) {
        [contentString insertString:@" " atIndex:0];//使得看起来接近左对齐
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.text = self.cellString;
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

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

#pragma mark - other

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
