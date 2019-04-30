//
//  LoginViewController.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/29.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "LoginViewController.h"
#import <ReactiveObjC.h>

@interface LoginViewController ()
@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UITextField *passTextField;
@property (nonatomic, strong)UIButton *ensureBtn;
@property (nonatomic, strong)RACCommand *btnPressCommand;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.passTextField];
    [self.view addSubview:self.ensureBtn];
    
    RAC(self.ensureBtn,enabled) = [RACSignal combineLatest:@[self.nameTextField.rac_textSignal,self.passTextField.rac_textSignal] reduce:^id _Nonnull(NSString * account,NSString * password){
        return @(account.length&&password.length>5);
    }];
    [[self.ensureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"登陆接口调用，事件点击了");
        [self.btnPressCommand execute:@{@"account":self.nameTextField.text,@"password":self.passTextField.text}];
    }];
    
    [self askData];
}
- (void)askData {
    self.btnPressCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"组合参数，准备发送登录请求 - %@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            NSLog(@"开始请求");
            
            NSLog(@"请求成功");
            
            NSLog(@"处理数据");
            
            [subscriber sendNext:@"请求完成，数据给你"];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"结束了");
            }];
        }];
    }];
    
    [self.btnPressCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"登录成功，跳转页面");
    }];
    
    [[self.btnPressCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在执行中……");
        }else{
            NSLog(@"执行结束了");
        }
    }];
}

#pragma mark ------lazy
- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 150, 200, 50)];
        _nameTextField.backgroundColor = [UIColor redColor];
        _nameTextField.placeholder = @"请输入账号";
    }
    return _nameTextField;
}
- (UITextField *)passTextField {
    if (!_passTextField) {
        _passTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 210, 200, 50)];
        _passTextField.backgroundColor = [UIColor redColor];
        _passTextField.placeholder = @"请输入密码";
    }
    return _passTextField;
}
- (UIButton *)ensureBtn {
    if (!_ensureBtn) {
        _ensureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_ensureBtn setTitle:@"登陆" forState:UIControlStateNormal];
        [_ensureBtn setBackgroundColor:[UIColor cyanColor]];
        [_ensureBtn setTintColor:[UIColor redColor]];
        _ensureBtn.frame = CGRectMake(0, 270, 200, 50);
        _ensureBtn.enabled = NO;
    }
    return _ensureBtn;
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
