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
//  BaseView.h
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/17.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView

@property (nonatomic, strong) RACSubject *btnClickSignal;

@end

NS_ASSUME_NONNULL_END
