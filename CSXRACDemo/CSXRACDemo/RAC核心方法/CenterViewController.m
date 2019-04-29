//
//  CenterViewController.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/29.
//  Copyright © 2019 曹世鑫. All rights reserved.
//


//在RAC中我们会看到bind，了解一下如何使用吧
#import "CenterViewController.h"
#import <ReactiveObjC.h>
#import <RACReturnSignal.h>

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"bind" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(0, 190, 200, 50);
    [btn1 addTarget:self action:@selector(btn1Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)btn1Choose:(UIButton *)sender {
    //1、创建信号
    RACSubject * subject = [RACSubject subject];
    //2、绑定信号
    RACSignal * signal = [subject bind:^RACSignalBindBlock _Nonnull{
        return ^RACSignal *(id _Nullable value, BOOL *stop){
            //return [[RACSignal alloc] init];
            
            /*
             至于为什么返回value，这个就简单啦，通过我们发送的数据是字符串，一个对象，总不可能用一个bool去表示吧，
             所以value就是我们发送的数据，如果不需要进行处理，直接返回value就ok了。
             */
            return [RACReturnSignal return:value];
            //字典转模型
        };
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"收到的数据 - %@",x);
    }];
    
    [subject sendNext:@"启动自毁程序"];
    //因为我们用原始信号(subject)发送了数据,但是返回的这个信号里面并没有这个数据如果使用了 return [[RACSignal alloc] init]，所以就挂掉啦。
    
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
