//
//  FilterObject.m
//  GPUImageDemo
//
//  Created by 张浩 on 2017/3/30.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "FilterObject.h"

@implementation FilterObject
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.enabled = YES;
        self.canChangeValue = YES;
    }
    return self;
}



@end
