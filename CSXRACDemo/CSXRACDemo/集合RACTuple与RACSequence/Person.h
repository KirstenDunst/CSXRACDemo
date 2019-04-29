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
//  Person.h
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/29.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, assign)int age;

+ (instancetype)personWithDict:(NSDictionary *)tempDic;
@end

NS_ASSUME_NONNULL_END
