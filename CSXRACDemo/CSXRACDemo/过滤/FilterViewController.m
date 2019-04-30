//
//  FilterViewController.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/29.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "FilterViewController.h"
#import <ReactiveObjC.h>
#import "Person.h"

@interface FilterViewController ()
@property (nonatomic, strong)UITextField *textfield;
@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.textfield];
    
    [self resultChangeChoose];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"ignore 忽略" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(0, 160, 300, 50);
    [btn1 addTarget:self action:@selector(btn1Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"ignoreValues 忽略掉所有的值" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(0, 220, 300, 50);
    [btn2 addTarget:self action:@selector(btn2Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn3 setTitle:@"ignore 忽略掉某些的值" forState:UIControlStateNormal];
    btn3.frame = CGRectMake(0, 280, 300, 50);
    [btn3 addTarget:self action:@selector(btn3Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn4 setTitle:@"take 指定哪些信号 正序" forState:UIControlStateNormal];
    btn4.frame = CGRectMake(0, 340, 300, 50);
    [btn4 addTarget:self action:@selector(btn4Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn5 setTitle:@"take 指定哪些信号 倒序" forState:UIControlStateNormal];
    btn5.frame = CGRectMake(0, 400, 300, 50);
    [btn5 addTarget:self action:@selector(btn5Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn6 setTitle:@"takeUntil 标记" forState:UIControlStateNormal];
    btn6.frame = CGRectMake(0, 460, 300, 50);
    [btn6 addTarget:self action:@selector(btn6Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn7 setTitle:@"distinctUntilChanged 剔除一样的信号" forState:UIControlStateNormal];
    btn7.frame = CGRectMake(0, 520, 300, 50);
    [btn7 addTarget:self action:@selector(btn7Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn7];
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn8 setTitle:@"还可以忽略掉数组、字典，但是不可以忽略模型" forState:UIControlStateNormal];
    btn8.frame = CGRectMake(0, 580, 300, 50);
    [btn8 addTarget:self action:@selector(btn8Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn8];
}

- (void)resultChangeChoose {
    //1.fillter 过滤
    [[self.textfield.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 5;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"filter筛选结果之后的内容>>>>>%@",x);
    }];
}
- (void)btn1Choose:(UIButton *)sender {
    //2.ignore 忽略
    RACSubject *subject = [RACSubject subject];
    [[subject ignore:@"a"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"a"];//不会打印
    [subject sendNext:@"a1"];//可以打印
    [subject sendNext:@"b"];//可以打印
}
- (void)btn2Choose:(UIButton *)sender {
    //3.ignoreValues 忽略掉所有的值
    RACSubject *subject1 = [RACSubject subject];
    [[subject1 ignoreValues] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject1 sendNext:@"a"];//不会打印
    [subject1 sendNext:@"a1"];//不会打印
    [subject1 sendNext:@"b"];//不会打印
}
- (void)btn3Choose:(UIButton *)sender {
    //4.ignore 忽略掉某些的值
    //假设要忽略掉 1 2 3 4
    RACSubject *subject2 = [RACSubject subject];
    [[[[[subject2 ignore:@"1"] ignore:@"2"] ignore:@"3"] ignore:@"4"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject2 sendNext:@"1"];//不会打印
    [subject2 sendNext:@"2"];//不会打印
    [subject2 sendNext:@"3"];//不会打印
    [subject2 sendNext:@"4"];//不会打印
    [subject2 sendNext:@"5"];//可以打印
}
- (void)btn4Choose:(UIButton *)sender {
    //5.take 指定哪些信号 正序
    RACSubject *subject3 = [RACSubject subject];
    //这里后面的数字显示的是排序之后输出的数量
    [[subject3 take:1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject3 sendNext:@"1"];
    [subject3 sendNext:@"2"];
    [subject3 sendNext:@"3"];
    [subject3 sendNext:@"4"];
    [subject3 sendNext:@"5"];
}
- (void)btn5Choose:(UIButton *)sender {
    //6.take 指定哪些信号 倒序
    RACSubject *subject4 = [RACSubject subject];
    //这里后面的数字显示的是排序之后输出的数量
    [[subject4 takeLast:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject4 sendNext:@"1"];
    [subject4 sendNext:@"2"];
    [subject4 sendNext:@"3"];
    [subject4 sendNext:@"4"];
    [subject4 sendNext:@"5"];
    //在使用takeLast的使用一定要告诉系统，发送完成了，不然就没效果。
    [subject4 sendCompleted];
}
- (void)btn6Choose:(UIButton *)sender {
    //7.takeUntil 标记
    //takeUntil需要一个信号作为标记，当标记的信号发送数据，就停止。
    RACSubject *subject = [RACSubject subject];
    RACSubject * subject1 = [RACSubject subject];
    
    [[subject takeUntil:subject1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject1 subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    
    [subject1 sendNext:@"Stop"];
    
    [subject sendNext:@"4"];
    [subject sendNext:@"5"];
}
- (void)btn7Choose:(UIButton *)sender {
    //distinctUntilChanged 剔除一样的信号
    RACSubject *subject = [RACSubject subject];
    
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"x"];
    [subject sendNext:@"x"];
    [subject sendNext:@"x"];
}
- (void)btn8Choose:(UIButton *)sender {
    //还可以忽略掉数组、字典，但是不可以忽略模型
    RACSubject * subject = [RACSubject subject];
    
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@[@1]];
    [subject sendNext:@[@1]];
    
    [subject sendNext:@{@"name":@"jack"}];
    [subject sendNext:@{@"name":@"jack"}];
    
    Person * p1 = [[Person alloc] init];
    p1.name = @"jj";
    p1.age = 20;
    
    Person * p2 = [[Person alloc] init];
    p2.name = @"jj";
    p2.age = 20;
    
    [subject sendNext:p1];
    [subject sendNext:p2];
}


#pragma mark -------lazy
- (UITextField *)textfield {
    if (!_textfield) {
        _textfield = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, 300, 50)];
        _textfield.backgroundColor = [UIColor redColor];
        _textfield.placeholder = @"这是一个输入框，让你好找";
    }
    return _textfield;
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
