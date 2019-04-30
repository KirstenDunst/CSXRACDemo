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
#import "CenterViewController.h"
#import "TupleSequenceViewController.h"
#import "LeftSelectorViewController.h"
#import "MapViewController.h"
#import "FilterViewController.h"
#import "LoginViewController.h"

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
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn5 setTitle:@"bind" forState:UIControlStateNormal];
    btn5.frame = CGRectMake(0, 430, 200, 50);
    [btn5 addTarget:self action:@selector(btn5Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn6 setTitle:@"Tuple" forState:UIControlStateNormal];
    btn6.frame = CGRectMake(0, 490, 200, 50);
    [btn6 addTarget:self action:@selector(btn6Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn7 setTitle:@"rac_liftSelector" forState:UIControlStateNormal];
    btn7.frame = CGRectMake(0, 550, 200, 50);
    [btn7 addTarget:self action:@selector(btn7Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn7];
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn8 setTitle:@"Map映射" forState:UIControlStateNormal];
    btn8.frame = CGRectMake(0, 610, 200, 50);
    [btn8 addTarget:self action:@selector(btn8Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn8];
    UIButton *btn9 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn9 setTitle:@"过滤" forState:UIControlStateNormal];
    btn9.frame = CGRectMake(0, 670, 200, 50);
    [btn9 addTarget:self action:@selector(btn9Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn9];
    UIButton *btn10 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn10 setTitle:@"登陆页面MVVM" forState:UIControlStateNormal];
    btn10.frame = CGRectMake(0, 730, 200, 50);
    [btn10 addTarget:self action:@selector(btn10Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn10];
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
- (void)btn5Choose:(UIButton *)sender {
    [self.navigationController pushViewController:[CenterViewController new] animated:YES];
}
- (void)btn6Choose:(UIButton *)sender {
    [self.navigationController pushViewController:[TupleSequenceViewController new] animated:YES];
}
- (void)btn7Choose:(UIButton *)sender {
    [self.navigationController pushViewController:[LeftSelectorViewController new] animated:YES];
}
- (void)btn8Choose:(UIButton *)sender {
    [self.navigationController pushViewController:[MapViewController new] animated:YES];
}
- (void)btn9Choose:(UIButton *)sender {
    [self.navigationController pushViewController:[FilterViewController new] animated:YES];
}
- (void)btn10Choose:(UIButton *)sender {
    [self.navigationController pushViewController:[LoginViewController new] animated:YES];
}
@end
