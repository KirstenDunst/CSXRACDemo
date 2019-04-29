//
//  BaseView.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/17.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "BaseView.h"

@interface BaseView ()
@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, strong)UIButton *otherBtn;
@end

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    [self addSubview:self.btn];
    [self addSubview:self.otherBtn];
}

- (void)btnClick:(UIButton *)sender {
    NSLog(@"事件处理view内部的点击处理，先处理内部的响应事件，然后z才会触发外部的响应元组");
}

- (void)otherBtnClick:(UIButton *)sender {
    [self.btnClickSignal sendNext:@"我可以代替代理哦"];
}

#pragma mark --------lazy
- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn setTitle:@"按钮" forState:UIControlStateNormal];
        _btn.frame = CGRectMake(0, 0, 50, 40);
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
- (UIButton *)otherBtn {
    if (!_otherBtn) {
        _otherBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_otherBtn setTitle:@"另一个" forState:UIControlStateNormal];
        _otherBtn.frame = CGRectMake(50, 0, 50, 40);
        [_otherBtn addTarget:self action:@selector(otherBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _otherBtn;
}
- (RACSubject *)btnClickSignal{
    if (!_btnClickSignal) {
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
