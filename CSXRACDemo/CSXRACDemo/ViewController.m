//
//  ViewController.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/15.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "ViewController.h"
#import "RACModel.h"
#import "BaseUseVC/BaseUseViewController.h"
#import "TimerViewController.h"
#import "MulticastConnectionViewController.h"
#import "CommandViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"点我试一下" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 90, 200, 50);
    [btn addTarget:self action:@selector(btnChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"基本用法" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(0, 190, 200, 50);
    [btn1 addTarget:self action:@selector(btn1Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"定时器" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(0, 250, 200, 50);
    [btn2 addTarget:self action:@selector(btn2Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn3 setTitle:@"RACMulticastConnnection" forState:UIControlStateNormal];
    btn3.frame = CGRectMake(0, 310, 200, 50);
    [btn3 addTarget:self action:@selector(btn3Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn4 setTitle:@"RACCommand" forState:UIControlStateNormal];
    btn4.frame = CGRectMake(0, 370, 200, 50);
    [btn4 addTarget:self action:@selector(btn4Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
}

- (void)btnChoose:(UIButton *)sender {
//    [RACModel RACSignalDeal];
//    [RACModel RACDisposableDeal];
//    [RACModel RACSubjectDeal];
    [RACModel RACReplaySubjectDeal];
}

- (void)btn1Choose:(UIButton *)sender {
    [self.navigationController pushViewController:[BaseUseViewController new] animated:YES];
}
- (void)btn2Choose:(UIButton *)sender {
    [self.navigationController pushViewController:[TimerViewController new] animated:YES];
}
- (void)btn3Choose:(UIButton *)sender {
    [self.navigationController pushViewController:[MulticastConnectionViewController new] animated:YES];
}
- (void)btn4Choose:(UIButton *)sender {
    [self.navigationController pushViewController:[CommandViewController new] animated:YES];
}
@end
