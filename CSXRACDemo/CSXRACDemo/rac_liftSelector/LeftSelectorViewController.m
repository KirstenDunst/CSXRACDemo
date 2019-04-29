//
//  SelectorViewController.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/29.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "LeftSelectorViewController.h"
#import <ReactiveObjC.h>

@interface LeftSelectorViewController ()

@end

@implementation LeftSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"LeftSelector" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(0, 190, 200, 50);
    [btn1 addTarget:self action:@selector(btn1Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

}
//在线程里面一定有一个这样子的例子：同时下载三张图片，三张图片都下载完了，在显示到UI上面。那个时候是使用group，现在来看看RAC是如何做的。
- (void)btn1Choose:(UIButton *)sender {
    //1、先创建三个信号
    RACSignal * signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"我是图片1"];
        return nil;
        
    }];
    
    RACSignal * signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"我是图片2"];
        return nil;
        
    }];
    
    RACSignal * signal3 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"我是图片3"];
        return nil;
        
    }];
    
    //这里必须要有多个参数传入，如果不写参数，比如：直接调用方法updateUIPic，下面的方法名称也不带参数，那么运行会崩溃。（崩溃的意思就是，你的三张图片都不给UI，UI怎么更新啊？）
    [self rac_liftSelector:@selector(updateUIPic:pic2:pic3:) withSignalsFromArray:@[signal1,signal2,signal3]];
}

- (void)updateUIPic:(id)pic1 pic2:(id)pic2 pic3:(id)pic3 {
    //主要应用的场景就是，一个页面如果有多个请求，然后又要等到数据全部请求到，在刷新的时候，或者类似于这样子的场景就可以使用。
     NSLog(@"我要加载了 : pic1 - %@ pic2 - %@ pic3 - %@",pic1,pic2,pic3);
    //需要注意的是，block在主线程，如果有耗时操作，最好还是放在子线程运行。
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
