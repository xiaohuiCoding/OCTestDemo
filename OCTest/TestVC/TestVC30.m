//
//  TestVC30.m
//  OCTest

//  UITableView 优化 滚动停止加载一屏数据

//  Created by Apple on 2021/11/5.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import "TestVC30.h"

@interface XHModel : NSObject

@property (nonatomic, copy) NSString *URLString;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) BOOL needLoad;

@end

@implementation XHModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

@interface XHTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titLabel;
@property (nonatomic, strong) UILabel *subtitLabel;

- (void)setUpModel:(XHModel *)model;

@end

@implementation XHTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews {
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titLabel];
    [self.contentView addSubview:self.subtitLabel];

    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.bottom.offset(-10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(150).priority(MASLayoutPriorityDefaultHigh); // 设置高度(设置子元素约束的优先级，控制台打印警告信息⚠️)
//        make.height.mas_equalTo(self.imgView.mas_width).multipliedBy(1.0).priority(MASLayoutPriorityDefaultHigh); // 设置宽高比例
    }];
    [self.titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(20);
        make.top.offset(30);
    }];
    [self.subtitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titLabel);
        make.bottom.offset(-30);
    }];
    
//    MASAttachKeys(self.imgView); // 可以打印有警告的约束对象！
}

- (void)setUpModel:(XHModel *)model {
    if (model == nil) {
        self.imgView.image = [UIImage imageNamed:@"jenkins"];
        self.titLabel.text = @"默认标题";
        self.subtitLabel.text = @"默认副标题";
    } else {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.URLString] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.imgView.contentScaleFactor = [[UIScreen mainScreen] scale];
            self.imgView.contentMode = UIViewContentModeScaleAspectFill;
            self.imgView.clipsToBounds = YES;
            model.needLoad = YES;
        }];
        self.titLabel.text = model.title;
        self.subtitLabel.text = model.subtitle;
    }
    
    // TODO: 下面这种方案是利用Runloop的Mode特性，监听页面是否在滚动（处于TrackingMode），目前有点卡顿，待研究～
//    NSURL *URL = [NSURL URLWithString:URLString];
//    NSData *data = [NSData dataWithContentsOfURL:URL];
//    UIImage *image = [UIImage imageWithData:data];
//    [self.imgView performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        _imgView.layer.cornerRadius = 4;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

- (UILabel *)titLabel {
    if (!_titLabel) {
        _titLabel = [[UILabel alloc] init];
        _titLabel.font = [UIFont systemFontOfSize:18.0];
        _titLabel.textColor = UIColor.grayColor;
    }
    return _titLabel;
}

- (UILabel *)subtitLabel {
    if (!_subtitLabel) {
        _subtitLabel = [[UILabel alloc] init];
        _subtitLabel.font = [UIFont systemFontOfSize:14.0];
        _subtitLabel.textColor = UIColor.lightGrayColor;
    }
    return _subtitLabel;
}

@end

/*
 参考：
 https://www.jianshu.com/p/c55e06af1f93?utm_source=desktop&utm_medium=timeline
 */

@interface TestVC30 ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation TestVC30

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    // 当列表需要加载大量的数据时，若采用常规的加载方式，CPU的占用率在短时间内会快速增多，就会出现卡顿的体验！采用分屏懒加载的方式就会好很多～
    for (NSInteger i = 0; i < 1000; i++) {
        XHModel *model = [[XHModel alloc] init];
        if (i % 2 == 0) {
            model.URLString = @"https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png";
        } else {
            model.URLString = @"http://g.hiphotos.baidu.com/image/pic/item/472309f790529822c4ac8ad0d5ca7bcb0a46d402.jpg";
        }
        model.title = [NSString stringWithFormat:@"第%ld行标题",(long)i];
        model.subtitle = [NSString stringWithFormat:@"第%ld行副标题",(long)i];
        model.needLoad = NO;
        [self.datasource addObject:model];
        
        // 等tableView准备好后进行首屏数据的加载
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self cellLoadData];
        });
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate == NO) {
        [self cellLoadData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self cellLoadData];
}

- (void)cellLoadData {
    NSArray *array = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in array) {
        XHTableViewCell *cell = (XHTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row < self.datasource.count) {
            XHModel *model = self.datasource[indexPath.row];
            [cell setUpModel:model];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XHTableViewCell class]) forIndexPath:indexPath];
    if (indexPath.row < self.datasource.count) {
        XHModel *model = self.datasource[indexPath.row];
        if (model.needLoad == NO) {
            [cell setUpModel:nil];
        } else {
            [cell setUpModel:model];
        }
    }
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 144;
        [_tableView registerClass:[XHTableViewCell class] forCellReuseIdentifier:NSStringFromClass([XHTableViewCell class])];
    }
    return _tableView;
}

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

@end
