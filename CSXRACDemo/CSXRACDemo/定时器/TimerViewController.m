//
//  TimerViewController.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/29.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "TimerViewController.h"
#import <ReactiveObjC.h>

@interface TimerViewController ()
@property (nonatomic, strong)RACDisposable *dispoable;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"发送验证码" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(0, 250, 200, 50);
    [self.view addSubview:btn2];
    @weakify(self)
    [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        x.enabled = false;

        __block NSInteger time = 10;
        //这个就是RAC中的GCD
        self.dispoable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
            time--;
            NSString * title = time > 0 ? [NSString stringWithFormat:@"请等待 %ld 秒后重试",(long)time] : @"发送验证码";
            [btn2 setTitle:title forState:UIControlStateNormal | UIControlStateDisabled];
            btn2.enabled = (time==0)? YES : NO;
            if (time == 0) {
                [self.dispoable dispose];
            }
        }];
    }];
    
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
