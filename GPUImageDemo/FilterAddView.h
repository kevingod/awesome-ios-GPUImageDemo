//
//  FilterAddView.h
//  GPUImageDemo
//
//  Created by 张浩 on 2017/3/30.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterObject.h"

@class FilterAddView;

@protocol FilterAddViewDelegate <NSObject>

@required
-(UINavigationController *)filterAddViewNavigationController;

-(void)filterAddView:(FilterAddView *)view hasChangedFilterValue:(FilterObject *)obj;

-(void)filterAddView:(FilterAddView *)view addNewFilter:(FilterObject *)obj;

-(void)filterAddView:(FilterAddView *)view deleteFilter:(FilterObject *)obj;


@end


@interface FilterAddView : UIView

//所有的滤镜
@property(nonatomic, strong)NSMutableArray<FilterObject *> *allFilters;

@property(nonatomic, weak) id <FilterAddViewDelegate> delegate;

@end
