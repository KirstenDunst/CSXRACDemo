//
//  TupleSequenceViewController.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/29.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "TupleSequenceViewController.h"
#import <ReactiveObjC.h>
#import "Person.h"

@interface TupleSequenceViewController ()

@end

@implementation TupleSequenceViewController

/*
 在Swift中的元祖，可以放入任何的数据类型，包括基本数据类型，但是在OC中数组只能存储对象。
 而RAC的Tuple就是把OC的数组进行了一层封装
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"Tuple" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(0, 190, 200, 50);
    [btn1 addTarget:self action:@selector(btn1Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"RACSequence" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(0, 250, 200, 50);
    [btn2 addTarget:self action:@selector(btn2Choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}
- (void)btn1Choose:(UIButton *)sender {
    //创建方法：
    [RACTuple tupleWithObjects:@"大吉大利",@"今晚吃鸡",@66666666,@9999999, nil];
    [RACTuple tupleWithObjectsFromArray:@[@"大吉大利",@"今晚吃鸡",@66666666,@9999999]];
    [RACTuple tupleWithObjectsFromArray:@[@"大吉大利",@"今晚吃鸡",@66666666,@9999999] convertNullsToNils:YES];
    
    //使用
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"大吉大利",@"今晚吃鸡",@66666,@99999] convertNullsToNils:YES];
    id value = tuple[0];
    id value2 = tuple.first;
    NSLog(@"%@ %@",value,value2);
    
    //其实他就是一个数组……
}

//然后还有一个类：RACSequence，这个类可以用来代替我们的NSArray或者NSDictionary，主要就是用来快速遍历，和用来字段转模型。
- (void)btn2Choose:(UIButton *)sender {
    //代替数组
    NSArray *array = @[@"大吉大利",@"今晚吃鸡",@66666666,@9999999];
    RACSequence *sequence = array.rac_sequence;
    RACSignal *signal = sequence.signal;
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"代替数组%@",x);
    }];
    
    //简化如下
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"简化后的数据%@",x);
    }];
    
    
    
    
    
    //代替字典
    NSDictionary *dict = @{@"大吉大利":@"今晚吃鸡",@"666666":@"999999",@"aaaaaa":@"dddddd"};
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"代替字典%@",x);
        //里面是一个数组，其中第一个元素是key，第二个元素是value，所以我们又可以这样子写：
        NSLog(@"key - %@ value - %@",x[0],x[1]);
    }];
    
    //简化处理之后
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *key, id value) = x;
        NSLog(@"简化后key - %@ value - %@",key,value);
    }];
    
    
    
    
    
    
    //字典转模型
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Model.plist" ofType:nil];
    NSArray *modelArr = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *mArray = [NSMutableArray array]; 
    [modelArr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        //
        [mArray addObject:[Person personWithDict:x]];
    }];
    
    //简化之后
    //id  _Nullable value 这里的value就是NSDictionary 所以我们就改成NSDictionary
    NSArray *persons = [[array.rac_sequence map:^id _Nullable(NSDictionary* value) {
        return [Person personWithDict:value];
    }] array];
    NSLog(@"%@",persons);
    //在使用.signal的时候，会依次给我们数组的元素，然后我们通过元素转化成为模型。
    
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
