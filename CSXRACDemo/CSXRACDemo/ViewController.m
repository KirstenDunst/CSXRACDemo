//
//  ViewController.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/15.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "ViewController.h"
#import "RACModel.h"

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
}

- (void)btnChoose:(UIButton *)sender {
//    [RACModel RACSignalDeal];
//    [RACModel RACDisposableDeal];
//    [RACModel RACSubjectDeal];
    [RACModel RACReplaySubjectDeal];
}

@end
