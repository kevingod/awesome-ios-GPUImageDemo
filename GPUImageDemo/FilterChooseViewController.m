//
//  FilterChooseViewController.m
//  GPUImageDemo
//
//  Created by 张浩 on 2017/3/30.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "FilterChooseViewController.h"
#import "GPUImageBeautifyFilter.h"
@interface FilterChooseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *filters;


@end

@implementation FilterChooseViewController
{
    filterSelectedBlock _block;

}

-(void)setSelectedBlock:(filterSelectedBlock)block
{
    _block = block;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark tableView
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filters.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    FilterObject *obj = self.filters[indexPath.row];
    cell.textLabel.text = obj.filterName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_block) {
        FilterObject *obj = self.filters[indexPath.row];
        _block(obj);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark getter
-(NSMutableArray *)filters
{
    if (!_filters)
    {
        _filters = [NSMutableArray array];
        FilterObject *obj = nil;

        {
            obj = [[FilterObject alloc]init];
            obj.canChangeValue = YES;
            obj.minValue = 0.0;
            obj.maxValue = 4.0;
            obj.currentValue = 1.0;
            obj.filterName = @"对比度";
            obj.filter = [[GPUImageContrastFilter alloc] init];
            obj.filterType = GPUIMAGE_CONTRAST;
            [_filters addObject:obj];
        }
        
        {
            obj = [[FilterObject alloc]init];
            obj.canChangeValue = YES;
            obj.minValue = 0.0;
            obj.maxValue = 24.0;
            obj.currentValue = 0.0;
            obj.filterName = @"高斯模糊";
            obj.filter = [[GPUImageGaussianBlurFilter alloc] init];
            obj.filterType = GPUIMAGE_GAUSSIAN;
            [_filters addObject:obj];
        }
        
        {
            obj = [[FilterObject alloc]init];
            obj.canChangeValue = NO;
            obj.filterName = @"iOS7毛玻璃";
            obj.filter = [[GPUImageiOSBlurFilter alloc] init];
            obj.filterType = GPUIMAGE_IOSBLUR;
            [_filters addObject:obj];
        }
        
        {
            obj = [[FilterObject alloc]init];
            obj.minValue = -1;
            obj.maxValue = 1;
            obj.currentValue = 0.0;
            obj.filterName = @"亮度";
            obj.filter = [[GPUImageBrightnessFilter alloc] init];
            obj.filterType = GPUIMAGE_BRIGHTNESS;
            [_filters addObject:obj];
        }
        
        {
            obj = [[FilterObject alloc]init];
            obj.minValue = -4;
            obj.maxValue = 4;
            obj.currentValue = 0.0;
            obj.filterName = @"曝光";
            obj.filter = [[GPUImageExposureFilter alloc] init];
            obj.filterType = GPUIMAGE_EXPOSURE;
            [_filters addObject:obj];
        }
        
        {
            obj = [[FilterObject alloc]init];
            obj.minValue = 0;
            obj.maxValue = 2;
            obj.currentValue = 1.0;
            obj.filterName = @"饱和度";
            obj.filter = [[GPUImageSaturationFilter alloc] init];
            obj.filterType = GPUIMAGE_SATURATION;
            [_filters addObject:obj];
        }
        
        {
            obj = [[FilterObject alloc]init];
            obj.canChangeValue = NO;
            obj.filterName = @"颜色反转";
            obj.filter = [[GPUImageColorInvertFilter alloc] init];
            obj.filterType = GPUIMAGE_COLORINVERT;
            [_filters addObject:obj];
        }
        
        {
            obj = [[FilterObject alloc]init];
            obj.canChangeValue = NO;
            obj.filterName = @"怀旧";
            obj.filter = [[GPUImageSepiaFilter alloc] init];
            obj.filterType = GPUIMAGE_UIELEMENT;
            [_filters addObject:obj];
        }
        
        {
            obj = [[FilterObject alloc]init];
            obj.minValue = 0;
            obj.maxValue = 1;
            obj.currentValue = 0.25;
            obj.filterName = @"素描";
            obj.filter = [[GPUImageSketchFilter alloc] init];
            obj.filterType = GPUIMAGE_SKETCH;
            [_filters addObject:obj];
        }
        
        {
            obj = [[FilterObject alloc]init];
            obj.canChangeValue = NO;
            obj.filterName = @"卡通";
            obj.filter = [[GPUImageToonFilter alloc] init];
            obj.filterType = GPUIMAGE_TOON;
            [_filters addObject:obj];
        }
        
        {
            obj = [[FilterObject alloc]init];
            obj.minValue = 1;
            obj.maxValue = 6;
            obj.currentValue = 1;
            obj.filterName = @"卡通-细腻";
            obj.filter = [[GPUImageSmoothToonFilter alloc] init];
            obj.filterType = GPUIMAGE_SMOOTHTOON;
            [_filters addObject:obj];
        }
        
        {
            obj = [[FilterObject alloc]init];
            obj.minValue = 3;
            obj.maxValue = 8;
            obj.currentValue = 3;
            obj.filterName = @"水粉画";
            obj.filter = [[GPUImageKuwaharaFilter alloc] init];
            obj.filterType = GPUIMAGE_KUWAHARA;
            [_filters addObject:obj];
        }
        
        {
            obj = [[FilterObject alloc]init];
            obj.canChangeValue = NO;
            obj.filterName = @"美颜";
            obj.filter = [[GPUImageBeautifyFilter alloc] init];
            obj.filterType = GPUIMAGE_Beautify;
            [_filters addObject:obj];
        }
    }
    return _filters;
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
