//
//  FilterAddView.m
//  GPUImageDemo
//
//  Created by 张浩 on 2017/3/30.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "FilterAddView.h"
#import "FilterChooseViewController.h"
#import "FilterTableViewCell.h"
@interface FilterAddView ()<UITableViewDelegate,UITableViewDataSource,FilterTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableFooter;
@property (nonatomic, strong) UIButton *addFilterButton;
@end


@implementation FilterAddView

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.allFilters = [NSMutableArray array];
        [self buildSubviews];
    }
    return self;
}

-(void)buildSubviews
{
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}



#pragma mark
#pragma mark ui action
-(void)chooseNewFilter:(UIButton *)sender
{
    FilterChooseViewController *controller = [[FilterChooseViewController alloc]initWithNibName:@"FilterChooseViewController" bundle:nil];
    [controller setTitle:@"选择滤镜"];
    __weak FilterAddView *weakself = self;
    [controller setSelectedBlock:^(FilterObject *obj) {
        [weakself.allFilters addObject:obj];
        if (weakself.delegate) {
            [weakself.delegate filterAddView:weakself addNewFilter:obj];
        }
        [weakself.tableView reloadData];
    }];
    [[self.delegate filterAddViewNavigationController]pushViewController:controller animated:YES];
}

#pragma mark
#pragma mark cellDelegate


-(void)cellValueChanged:(CGFloat)value
{
    
}



#pragma mark
#pragma mark tableView
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allFilters.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"FilterTableViewCell" owner:self options:nil].lastObject;
    [cell refreshUIWithFilter:self.allFilters[indexPath.row]];
    cell.delegate = self;
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return   UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (editingStyle ==UITableViewCellEditingStyleDelete)
    {
        FilterObject *obj = self.allFilters[indexPath.row];
        [obj.filter removeAllTargets];
        [self.allFilters removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.delegate filterAddView:self deleteFilter:obj];
    }
}

#pragma mark
#pragma mark getter
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]init];
        _tableView.allowsSelection = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.tableFooterView = self.tableFooter;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(UIView *)tableFooter
{
    if (!_tableFooter)
    {
        ;
        _tableFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CPUImageScreenWidth, 80.0)];
        _tableFooter.backgroundColor = UIColorFromRGB(0xffffff);
        [_tableFooter addSubview:self.addFilterButton];
    }
    return _tableFooter;
}

-(UIButton *)addFilterButton
{
    if (!_addFilterButton) {
        _addFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addFilterButton setTitle:@"添加滤镜" forState:UIControlStateNormal];
        [_addFilterButton addTarget:self action:@selector(chooseNewFilter:) forControlEvents:UIControlEventTouchUpInside];
        _addFilterButton.backgroundColor = UIColorFromRGB(0x16aff0);
        _addFilterButton.layer.masksToBounds = YES;
        _addFilterButton.layer.cornerRadius = 6.0;
        _addFilterButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_addFilterButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        _addFilterButton.frame = CGRectMake((CPUImageScreenWidth-120)/2, 20, 120, 40);
    }
    return _addFilterButton;
}

@end
