//
//  TestVC24.m
//  OCTest

//  ReactiveCocoa

//  Created by fengxiaohui on 2020/1/8.
//  Copyright © 2020 XIAOHUI. All rights reserved.
//

#import "TestVC24.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "RACReturnSignal.h"
/**
 疑问：
 rac_willDeallocSignal
*/

@interface TestVC24 ()

//信号
@property (nonatomic, strong) RACSignal *signal;

//用于当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block，造成副作用，可以使用这个类处理;
//可以通过RACSignal的-publish或者-muticast:方法创建。
@property (nonatomic, strong) RACMulticastConnection *connection;

//用于取消订阅或者清理资源，当信号发送完成或者发送错误的时候，就会自动触发它。
@property (nonatomic, strong) RACDisposable *disposable;

@end

@implementation TestVC24

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [self.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@页面即将消失",x);
//    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@页面即将出现",x);
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self basicGrammar_RAC];
    
//    [self UIViewClasses_RAC];
    
//    [self collectionClasses_RAC];
    
    [self timer_RAC];
}

#pragma mark - 基本语法及常用用法

- (void)basicGrammar_RAC {
    //1.多次订阅，多次创建
//    self.signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"发送的信号内容---"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal销毁了");
//        }];
//    }];
    
    
    
    //2.多次订阅，一次创建，一对多，当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block，造成副作用）
//    self.connection = [self.signal publish];
//
//    [self.connection.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@1",x);
//    }];
//
//    [self.connection.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@2",x);
//    }];
//
//    [self.connection.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@3",x);
//    }];
//
//    [self.connection connect];
    
    
    
    //3.command --- 命令
//        RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//            //必须要返回一个RACSignal信号
//            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//                [subscriber sendNext:@"发送的信号内容---"];
//                [subscriber sendError:[NSError errorWithDomain:@"error" code:-1 userInfo:nil]];
//                [subscriber sendCompleted];
//                return [RACDisposable disposableWithBlock:^{
//                    NSLog(@"signal销毁了");
//                }];
//            }];
//
//            //不能返回nil，如果真的是不需要传递信号，可以返回一个空信号。
//            //return [RACSignal empty]; //return nil; (X)
//        }];
//
//        //a.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
//        //b.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。
//        [command.executionSignals subscribeNext:^(id  _Nullable x) {
//            NSLog(@"executionSignals---%@",x);
//            [x subscribeNext:^(id  _Nullable x) {
//                NSLog(@"executionSignals---subscribeNext---%@",x);
//            }];
//        }];
//
//        //订阅后，可以直接获取信号中的数据
//        [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
//            NSLog(@"switchToLatest---%@",x);
//        }];
//
//        //订阅后，会监听命令是否执行完毕
//        [command.executing subscribeNext:^(NSNumber * _Nullable x) {
//            NSLog(@"executing---%@",x);
//        }];
//
//        //订阅后，此信号将发送所有将来的主要错误
//        [command.errors subscribeNext:^(NSError * _Nullable x) {
//            NSLog(@"errors---%@",x);
//        }];
//
//        //执行命令
//        [command execute:@"input"];
            
        
            
    //4.concat --- 当多个信号发出的时候，有顺序的接收信号
//    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"signal1"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal1销毁了");
//        }];
//    }];
    
//    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"signal2"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal2销毁了");
//        }];
//    }];
//
//    RACSignal *signal3 = [signal1 concat:signal2];
//    [signal3 subscribeNext:^(id  _Nullable x) {
//         NSLog(@"signal3---%@",x);
//    }];
    
    
    
    //5.then --- 用于连接两个信号，等待第一个信号完成，才会连接then返回的信号
//    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"signal1"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal1销毁了");
//        }];
//    }];
//
//    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"signal2"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal2销毁了");
//        }];
//    }];
//
//    RACSignal *signal3 = [signal1 then:^RACSignal * _Nonnull{
//        return signal2;
//    }];
//
//    [signal3 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"signal3---%@",x);
//    }];
    
    
    
    //6.merge --- 把多个信号合并为一个信号来监听，任何一个信号有新值的时候就会调用
//    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"signal1"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal1销毁了");
//        }];
//    }];
//
//    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"signal2"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal2销毁了");
//        }];
//    }];
//
//    RACSignal *signal3 = [signal1 merge:signal2];
//    [signal3 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"signal3---%@",x);
//    }];
    
    
    
    //7.zipWith --- 把两个信号压缩成一个信号，只有当两个信号都发出信号内容时(不需要两个信号同时发出，有延迟也可以)，才会触发
//    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [subscriber sendNext:@"signal1"];
//            [subscriber sendCompleted];
//        });
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal1销毁了");
//        }];
//    }];
//    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [subscriber sendNext:@"signal2"];
//            [subscriber sendCompleted];
//        });
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal2销毁了");
//        }];
//    }];
//
//    RACSignal *signal3 = [signal1 zipWith:signal2];
//    [signal3 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"signal3---%@",x);
//    }];
    
    

    //8.combineLatestWith --- 将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号(订阅者每次接收的参数都是所有信号的最新值),不论触发哪个信号都会触发合并的信号
//    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"signal1"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal1销毁了");
//        }];
//    }];
    
//    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"signal2"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal2销毁了");
//        }];
//    }];
//
//    RACSignal *signal3 = [signal1 combineLatestWith:signal2];
//    [signal3 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"signal3---%@",x);
//    }];


    
    //9.combineLatest && reduce 组合并聚合 --- 把多个信号的值按照自定义的组合返回
//    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"signal1"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal1销毁了");
//        }];
//    }];
//
//    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"signal2"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal2销毁了");
//        }];
//    }];
//
//    //combineLatest中传入几个信号，reduce中block中就可以写几个参数。
//    RACSignal *signal3 = [RACSignal combineLatest:@[signal1,signal2] reduce:^id (NSString *s1, NSString *s2) {
//        return [NSString stringWithFormat:@"%@ %@",s1,s2];
//    }];
//    [signal3 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"signal3---%@",x);
//    }];
    


    //10.rac_liftSelector --- 处理多个信号时，全部信号都获取到数据时，才执行回调；注意：传入几个信号，回调方法就要带几个参数，否则程序就会crash。
//    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"hello"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal1销毁了");
//        }];
//    }];
//
//    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"world"];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal2销毁了");
//        }];
//    }];
//
//    RACSignal *signal3 = [self rac_liftSelector:@selector(getResult:result2:) withSignalsFromArray:@[signal1,signal2]];
//    [signal3 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"signal3---%@",x);
//    }];
    

    
    //11.distinctUntilChanged --- 忽略重复（比如：忽略某些重复的数据）
//    RACSubject *subject = [RACSubject subject];
//    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"去重后的数据：%@",x);
//    }];
//    [subject sendNext:@"1"];
//    [subject sendNext:@"1"];
//    [subject sendNext:@"2"];
//    [subject sendNext:@"2"];
//    [subject sendCompleted];
    
    
    
    //12.RACSubject --- 信号提供者，自己可以充当信号，又能发送信号。
    //使用场景：通常用来代替代理，有了它，就不必定义代理了。
    
    //13.RACReplaySubject --- 重复提供信号类，RACSubject的子类。
    //使用场景一：如果一个信号每被订阅一次，就需要把之前的值重复发送一遍，使用重复提供信号类。
    //使用场景二：可以设置 capacity 数量来限制缓存的 value 的数量,即只缓充最新的几个值。

    //二者的区别：RACReplaySubject 可以先发送信号，再订阅信号，而 RACSubject 只能先订阅后发送。

    //例如：
//    RACSubject *subject = [RACSubject subject];
//    RACReplaySubject *replaySubject = [RACReplaySubject subject];
////    RACReplaySubject *replaySubject = [RACReplaySubject replaySubjectWithCapacity:0];
//
//    [subject sendNext:@"1"]; //发送无效
//    [replaySubject sendNext:@"1"]; //发送有效
//
//    [[RACScheduler mainThreadScheduler] afterDelay:2.0 schedule:^{
//        [subject sendNext:@"2"]; //发送有效
//        [replaySubject sendNext:@"2"]; //发送有效
//    }];
//
//    [subject subscribeNext:^(id x) {
//         NSLog(@"subscriber1: %@", x);//第二次
//    }];
//
//    [subject subscribeNext:^(id x) {
//         NSLog(@"subscriber2: %@", x);//第二次
//    }];
//
//    [replaySubject subscribeNext:^(id x) {
//         NSLog(@"Replaysubscriber1: %@", x);//第一次 //第三次
//    }];
//
//    [replaySubject subscribeNext:^(id x) {
//         NSLog(@"Replaysubscriber2: %@", x);//第一次 //第三次
//    }];
    
    
    
    //14.bind --- 绑定（这个方法目前还没找到适用场景，也就是没什么卵用，拿来练习用的。。）
    RACSubject *subject = [RACSubject subject];
    
    RACSignal *signal = [subject bind:^RACSignalBindBlock _Nonnull{
        
        return ^RACSignal *(id _Nullable value, BOOL *stop){
            
            return [RACReturnSignal return:value];
        };
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"收到的数据 --- %@",x);
    }];
    
    [subject sendNext:@"111"];
    
    
    
    //15.冷热信号的使用与转换
    //https://tech.meituan.com/2015/09/08/talk-about-reactivecocoas-cold-signal-and-hot-signal-part-1.html
}

- (void)getResult:(id)result result2:(id)result2 {
    NSLog(@"两个请求都完成，获取到的数据是：%@ %@",result,result2);
}

#pragma mark - UI控件类

- (void)UIViewClasses_RAC {
    //一.输入框
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
//    textField.layer.borderColor = UIColor.redColor.CGColor;
//    textField.layer.borderWidth = 1;
//    [self.view addSubview:textField];

    //RAC中默认的两个方法
//    [textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"输入框中的内容：%@",x);
//    }];
//
//    [textField.rac_newTextChannel subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"输入框中的内容：%@",x);
//    }];
    
    //1.map --- 监听输入框内容
//    [[textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
//        return [NSString stringWithFormat:@"输入框中的内容：%@",value];
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    //2.flattenMap --- 监听输入框内容
//    [[textField.rac_textSignal flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            [subscriber sendNext:[NSString stringWithFormat:@"输入框中的内容：%@",value]];
//            [subscriber sendCompleted];
//            return [RACDisposable disposableWithBlock:^{}];
//        }];
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    //3.filter 过滤（比如：过滤某些文本）
//    [[textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
//        return value.length > 3;
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"输入框中的内容：%@",x);
//    }];
    
    //4.ignore 忽略（比如：忽略某个文本）
//    [[textField.rac_textSignal ignore:@"a"] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"输入框中的内容：%@",x);
//    }];
    
    
    
    //二.按钮
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(100, 200, 200, 40);
//    button.backgroundColor = UIColor.lightGrayColor;
//    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    [button setTitleColor:UIColor.redColor forState:UIControlStateHighlighted];
//    [button setTitle:@"click" forState:UIControlStateNormal];
////    [button addTarget:self action:@selector(buttonCicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    //类似代理执行点击事件
//    [[self rac_signalForSelector:@selector(buttonCicked:)] subscribeNext:^(RACTuple * _Nullable x) {
//        NSLog(@"元组：%@",x);
//    }];
    
    //按钮监听点击事件
//    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        NSLog(@"按钮：%@",x);
//        //发送通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"noti" object:nil];
//    }];
//
//
//
//    //三.通知
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"noti" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//        NSLog(@"通知：%@",x);
//    }];
}

- (void)buttonCicked:(UIButton *)sender {
    NSLog(@"按钮被点击了");
}

#pragma mark - 集合类

- (void)collectionClasses_RAC {
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5"];
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"遍历数组的元素---%@",x);
    }];
}

#pragma mark - 定时器

- (void)timer_RAC {
    //1.类似NSTimer
//    @weakify(self)
//    self.disposable = [[RACSignal interval:2.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
//        @strongify(self)
//        NSLog(@"时间：%@",x);
//        [self.disposable dispose]; //执行后就杀死，否则每隔两秒就重复执行一次，类似timer中的repeat。
//    }];
    
    
    //2.延时
    [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"延时发送的内容"];
        [subscriber sendCompleted];
        return nil;
    }] delay:2.0] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

@end

/**
 参考资料：
 https://www.jianshu.com/p/87ef6720a096
 https://www.jianshu.com/p/5fc71f541b1c
 https://www.cnblogs.com/chglog/p/11051433.html
*/
