//
//  FilterTableViewCell.h
//  GPUImageDemo
//
//  Created by 张浩 on 2017/3/30.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FilterObject.h"

@protocol FilterTableViewCellDelegate <NSObject>

-(void)cellValueChanged:(CGFloat)value;

@end

@interface FilterTableViewCell : UITableViewCell

-(void)refreshUIWithFilter:(FilterObject *)obj;

@property(nonatomic,weak) id <FilterTableViewCellDelegate> delegate;
@end
