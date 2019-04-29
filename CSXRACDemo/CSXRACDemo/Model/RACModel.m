//
//  SignalModel.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/15.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "RACModel.h"
#import <ReactiveObjC.h>

@implementation RACModel
/*RAC三部曲
 1创建信号
 2订阅信号
 3发送数据
 */

+ (void)RACSignalDeal {
    //1.创建信号量
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"1。创建信号量signal");
        [subscriber sendNext:@"发送的数据内容signal"];
        NSLog(@"3。 信号发送完成，之后执行订阅的任务之后才继续执行signal");
        return nil;
    }];
    //订阅信号量
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"2。 signal收到的订阅从内容===%@",x);
    }];
    
    /*
     所以RACSignal的处理流程就是
     
     创建信号的block会在订阅信号的时候调用
     订阅信号的block会在订阅者发布信息的时候调用
     */
}


+ (void)RACDisposableDeal {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"1。disposable创建信号量");
        [subscriber sendNext:@"disposable发送的数据内容"];
        //这里如果我们把订阅者强引用，即self.subscriber = subscriber;那么就不会再走“4。disposable”的打印输出
        NSLog(@"3。disposable信号发送完成，之后执行的时间");
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"4。disposable");
        }];
    }];
    //订阅信号量
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"2。disposable订阅收到的内容====%@",x);
    }];
    /*或者创建一个RACDisposable来接受信号的订阅。例如如下，写信号的订阅，他也能够执行上面的1234顺序。
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"另一种情况2。disposable订阅收到的内容====%@",x);
    }];
    [disposable dispose];
     */
    
    
    /*
     创建RACDisposable对象劈头盖脸的就是一个block，但是这个block啥时候调用呢？
     1 订阅者被销毁
     2 RACDisposable 调用dispose取消订阅
     */
}

+ (void)RACSubjectReplaySubject {
    /*
     RACSignal是不具备发送信号的能力的，但是RACSubject这个类就可以做到订阅／发送为一体。之前还提到过RAC三部曲，在RACSuject中同样适用。
     */
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    //2.订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅信号");
    }];
    //3.发送数据
    [subject sendNext:@"发送的数据"];
    /*内部代码逻辑：
     1、创建的subject的是内部会创建一个数组_subscribers用来保存所有的订阅者
     2、订阅信息的时候会创建订阅者，并且保存到数组中
     3、遍历subject中_subscribers中的订阅者，依次发送信息
     */
    
    
     //所以对于RACSignal不同的地方是：他可以被订阅多次，并且只能是先订阅后发布。
    //创建信号，这里会给_subscribers数据初始化，还初始化_disposable取消
    RACSubject *subject1 = [RACSubject subject];
    [subject1 sendNext:@"先发送数据，订阅是收不到的，发送的是已经声明订阅的才能接收到"];
    //订阅信号量，这里会创建一个订阅者，并且保存到_subscribers数组中，等待被调用
    [subject1 subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个信号量订阅======%@",x);
    }];
    //再次订阅一次
    [subject1 subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个信号量订阅======%@",x);
    }];
    //发送数据,会调用_subscribers数组中所有的订阅着，然后执行相应的block。
    [subject1 sendNext:@"发送数据接收"];
    
    //？最后还有一个小问题，那就是如果我非要先发送在订阅，并且也要能收到怎么处理呢？看下一个RACReplaySubject.
}

//RACReplaySubject
//RACReplaySubject，他继承RACSubject，他的目的就是为例解决上面必须先订阅后发送的问题。
+ (void)RACReplaySubjectDeal {
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    [replaySubject sendNext:@"发送数据"];
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"RACReplaySubject订阅的接受结果====%@",x);
    }];
}

@end
