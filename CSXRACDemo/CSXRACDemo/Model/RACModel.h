/*      __.--'\     \.__./     /'--.__
    _.-'       '.__.'    '.__.'       '-._
  .'                曹世鑫                 '.
/                                           \
|    CSDN:https://me.csdn.net/BUG_delete     |
|   GitHub:https://github.com/KirstenDunst   |
\         .---.              .---.          /
  '._    .'     '.''.    .''.'     '.    _.'
     '-./            \  /            \.-'
                      ''*/
//
//  SignalModel.h
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/15.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACModel : NSObject

//RACSignal:顾名思义，信号类，signal本身不具备发送信号的能力
+ (void)RACSignalDeal;

//RACDisposable这个类。
+ (void)RACDisposableDeal;

//RACSubject
+ (void)RACSubjectDeal;

//RACReplaySubject
+ (void)RACReplaySubjectDeal;

@end

NS_ASSUME_NONNULL_END
