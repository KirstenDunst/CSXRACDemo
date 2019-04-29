//
//  MapViewController.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/29.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "MapViewController.h"
#import <ReactiveObjC.h>
#import <RACReturnSignal.h>

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"flattenMap" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(0, 190, 200, 50);
    [btn1 addTarget:self action:@selector(btn1Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"Map实现" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(0, 250, 200, 50);
    [btn2 addTarget:self action:@selector(btn2Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)btn1Choose:(UIButton *)sender {
    //我们平时的用法
    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [subject sendNext:@"what happend？"];
    
    
    //信号量处理
    RACSubject *subject1 = [RACSubject subject];
    RACSignal *signal = [subject1 flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return [RACReturnSignal return:value];
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [subject1 sendNext:@"what happend？"];
    //稍微整理之后
    RACSubject *subject2 = [RACSubject subject];
    [[subject2 flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        value = [NSString stringWithFormat:@"%@ 你别问我，我也不知道！",value];
        return [RACReturnSignal return:value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [subject2 sendNext:@"what happend？"];
    
}

//使用map完成上面的功能
- (void)btn2Choose:(UIButton *)sender {
    
    RACSubject *subject = [RACSubject subject];
    [[subject map:^id _Nullable(id  _Nullable value) {
        return [NSString stringWithFormat:@"%@ 你别问我，我也不知道！",value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [subject sendNext:@"what happend？"];
    
    
    
    //第一种：双重订阅
    RACSubject *subjectOfSignal = [RACSubject subject];
    RACSubject *subject1 = [RACSubject subject];
    [subjectOfSignal subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"第一种：双重订阅：%@",x);
        }];
    }];
    [subjectOfSignal sendNext:subject1];
    [subject1 sendNext:@"弄啥嘞"];
    
    
    //第二种：订阅最新的信号
    RACSubject *subjectOfSignal2 = [RACSubject subject];
    RACSubject *subject2 = [RACSubject subject];
    [subjectOfSignal2.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二种：订阅最新信号：%@",x);
    }];
    [subjectOfSignal2 sendNext:subject2];
    [subject2 sendNext:@"弄啥嘞"];
    
    
    //现在又多一种:
    RACSubject *subjectOfSignal3 = [RACSubject subject];
    RACSubject *subject3 = [RACSubject subject];
    [[subjectOfSignal3 flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return value;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"flattenMap订阅：%@",x);
    }];
    [subjectOfSignal3 sendNext:subject3];
    [subject3 sendNext:@"弄啥嘞"];
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
