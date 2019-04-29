//
//  Person.m
//  CSXRACDemo
//
//  Created by 曹世鑫 on 2019/4/29.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (instancetype)personWithDict:(NSDictionary *)tempDic {
    return [[self alloc]initWithDictionary:tempDic];
}

- (instancetype)initWithDict:(NSDictionary *)tempDic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:tempDic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


@end
