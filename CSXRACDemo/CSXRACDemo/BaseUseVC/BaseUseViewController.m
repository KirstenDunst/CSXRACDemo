//
//  BaseUseViewController.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/17.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "BaseUseViewController.h"
#import "BaseView.h"
#import <ReactiveObjC.h>

@interface BaseUseViewController ()
@property (nonatomic, strong)BaseView *redView;
@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, strong)UITextField *textfield;
@property (nonatomic, strong)UILabel *showLabel;
@end

@implementation BaseUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"RAC的基本用法";
    [self.view addSubview:self.redView];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.textfield];
    [self.view addSubview:self.showLabel];

    //1、监听方法，并且可以通过元组把参数传出
    [[self.redView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(RACTuple * _Nullable x) {
        //它会先将内部view'的响应方法btnClick先执行完然后
        NSLog(@"你竟然响应我了 厉害了");
        NSLog(@">>>>>>>>%@",x);
    }];
    
    
    
    //2.kvo
    [[self.redView rac_valuesAndChangesForKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        NSLog(@"1 - %@",x);
    }];
    //跟简单的写法的
    //方法2
    [[self.redView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"2 - %@",x);
    }];
    //方法三
    [RACObserve(self.redView, frame) subscribeNext:^(id  _Nullable x) {
        NSLog(@"3 - %@",x);
    }];
    //方法二和方法三都是在程序运行的时候就会监听到，方案一是在值改变的时候才打印输出。
    
    
    
    
    //3、监听事件
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@">>>>>>>>>>按钮点击响应》〉》〉》〉》%@",x);
    }];
    
    
    
    
    
    
    //4、通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@">>>>>rac监听收到的键盘通知block处理");
    }];
    
    
    
    
    
    //5、监听textfield舒输入
    [self.textfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"输入框输入内容>>>>>>%@",x);
//        self.showLabel.text = x;
    }];
    //另外一种更简单的写法
    RAC(self.showLabel,text) = self.textfield.rac_textSignal;
    //RAC(对象，对象的属性) = (一个信号);
    
    
    
    
    
    
    //6、代替代理
    [self.redView.btnClickSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.redView.frame = CGRectMake(50, 120, 200, 50);
}


#pragma mark -------lazy
- (BaseView *)redView {
    if (!_redView) {
        _redView = [[BaseView alloc]initWithFrame:CGRectMake(20, 100, 100, 60)];
    }
    return _redView;
}
- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn.frame = CGRectMake(0, CGRectGetMaxY(self.redView.frame)+20, 100, 50);
        [_btn setBackgroundColor:[UIColor cyanColor]];
        [_btn setTitle:@"标题" forState:UIControlStateNormal];
    }
    return _btn;
}
- (UITextField *)textfield {
    if (!_textfield) {
        _textfield = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.btn.frame)+20, 190, 50)];
        _textfield.backgroundColor = [UIColor cyanColor];
        _textfield.placeholder = @"请输入内容";
    }
    return _textfield;
}
- (UILabel *)showLabel {
    if (!_showLabel) {
        _showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textfield.frame)+20, 100, 50)];
        _showLabel.backgroundColor = [UIColor cyanColor];
    }
    return _showLabel;
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
