//
//  CommandViewController.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/29.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

//Command翻译过来就是命令
#import "CommandViewController.h"
#import <ReactiveObjC.h>

@interface CommandViewController ()

@end

@implementation CommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"RACCommand" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(0, 190, 200, 50);
    [btn1 addTarget:self action:@selector(btn1Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"switchToLatest" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(0, 250, 200, 50);
    [btn2 addTarget:self action:@selector(btn2Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn3 setTitle:@"skip" forState:UIControlStateNormal];
    btn3.frame = CGRectMake(0, 310, 200, 50);
    [btn3 addTarget:self action:@selector(btn3Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
}

- (void)btn1Choose:(UIButton *)sender {
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@">>>>>>%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"信号发布信息"];
            
            return nil;
        }];
    }];
    
//    //1.发送信号的第一种方式
//    RACSignal *signal = [command execute:@"开始执行"];
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@">>>>>>接收到的数据 -- %@",x);
//    }];
    
//    //2.executionSignals就是用来发送信号的信号源，需要注意的是这个方法一定要在执行execute方法之前，否则就不起作用了
//    [command.executionSignals subscribeNext:^(id  _Nullable x) {
//        [x subscribeNext:^(id  _Nullable x) {
//            NSLog(@"接收数据 - %@",x);
//        }];
//    }];
//    [command execute:@"开始执行"];
    
    //3.其中switchToLatest表示的是最新发送的信号，
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收数据 - %@",x);
    }];
    [command execute:@"开始执行"];
}

//验证一下看switchToLatest是不是最新的信号吧。
- (void)btn2Choose:(UIButton *)sender {
    //1、先创建5个RACSubject，其中第一个为信号中的信号（也就是发送的数据是信号）
    RACSubject *signalofsignal = [RACSubject subject];
    RACSubject *signal1 = [RACSubject subject];
    RACSubject *signal2 = [RACSubject subject];
    RACSubject *signal3 = [RACSubject subject];
    RACSubject *signal4 = [RACSubject subject];
//    //依次执行
//    [signalofsignal subscribeNext:^(id  _Nullable x) {
//        [x subscribeNext:^(id  _Nullable x) {
//            NSLog(@"switchToLatest检测的结果：%@",x);
//        }];
//    }];
    //2、然后我们就订阅信号中的信号（因为我们约定了，发送的是信号，所以接收到的也是信号，既然是信号，那就可以订阅）
    [signalofsignal.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"switchToLatest检测的结果：%@",x);
    }];
    //3、发送数据
    [signalofsignal sendNext:signal1];
    [signalofsignal sendNext:signal2];
    [signalofsignal sendNext:signal3];
    [signalofsignal sendNext:signal4];
    
    [signal1 sendNext:@"1"];
    [signal2 sendNext:@"2"];
    [signal3 sendNext:@"3"];
    [signal4 sendNext:@"4"];
}

- (void)btn3Choose:(UIButton *)sender {
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"input -- %@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"666666666"];
            //方法二中的介绍使用
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@">>>>>%@",x);
    }];
    
#pragma mark ------方法一
//    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
//        if ([x boolValue]) {
//            NSLog(@"还在执行");
//        }else {
//            NSLog(@"执行结束了");
//        }
//    }];
//
//    [command execute:@"9999999"];
    /*在上面的过程中，我们发现有两点不太对：
    1、刚运行的时候就来了一次执行结束，这个不是我们想要的
    2、并没有结束，但其实我们已经完成了
     */
    
    //第2个问题，在command的block我们可以注意到，我们在signal的block中只发送了数据，并没有告诉外界发送完成了，所以就导致了，一直没发送完成，所以我们在发送数据之后加上[subscriber sendCompleted];
    //第1个问题，为什么第一次就执行结束了，这次的判断不是我们想要的， 那我们可不可以跳过呢 答案肯定是可以的啦  这个时候我需要用到一个方法skip，这个方法后面有一个参数，填的就是忽略的次数，我们这个时候只想忽略第一次， 所以就填1
    
#pragma mark -----方法二
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"还在执行");
        }else{
            NSLog(@"执行结束了");
        }
    }];
    [command execute:@"9999999"];
    
    /*
     既然提到了skip那就随便可以提提其它的类似的方法
     filter过滤某些
     ignore忽略某些值
     startWith从哪里开始
     skip跳过（忽略）次数
     take取几次值 正序
     takeLast取几次值 倒序
     */
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
