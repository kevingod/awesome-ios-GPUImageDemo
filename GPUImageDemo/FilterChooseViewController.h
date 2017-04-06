//
//  FilterChooseViewController.h
//  GPUImageDemo
//
//  Created by 张浩 on 2017/3/30.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterObject.h"


typedef void (^filterSelectedBlock)(FilterObject *obj);

@interface FilterChooseViewController : UIViewController

-(void)setSelectedBlock:(filterSelectedBlock)block;

@end
