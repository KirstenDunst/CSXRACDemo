//
//  MulticastConnectionViewController.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/29.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "MulticastConnectionViewController.h"
#import <ReactiveObjC.h>

@interface MulticastConnectionViewController ()

@end

@implementation MulticastConnectionViewController

/*
 冷信号是一段视频,发过来可以完整的接收到,
 而热信号就好比是直播,你在订阅的时候有可能信息错过了的话就会收不到.
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"单一的信号请求使用" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(0, 190, 200, 50);
    [btn1 addTarget:self action:@selector(btn1Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"MulticastConnection" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(0, 250, 200, 50);
    [btn2 addTarget:self action:@selector(btn2Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

//这里同步网络发送，每次的订阅都是一次新的网络请求处理优化
- (void)btn1Choose:(UIButton *)sender {
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送网络请求");
        [subscriber sendNext:@"得到网络请求数据"];
        return nil;
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"1 - %@",x);
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"2 - %@",x);
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"3 - %@",x);
    }];
}

//网络请求的结果多个界面的不同刷新数据分发，订阅。
- (void)btn2Choose:(UIButton *)sender {
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送网络请求");
        [subscriber sendNext:@"得到网络请求数据"];
        return nil;
    }];
    
    RACMulticastConnection *connect = [signal publish];
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"1 - %@",x);
    }];
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"2 - %@",x);
    }];
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"3 - %@",x);
    }];
    
    [connect connect];
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
