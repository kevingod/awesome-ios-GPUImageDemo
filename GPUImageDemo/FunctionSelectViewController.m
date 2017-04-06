//
//  FunctionSelectViewController.m
//  GPUImageDemo
//
//  Created by 张浩 on 2017/3/30.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "FunctionSelectViewController.h"
#import "VideoRecordViewController.h"
@interface FunctionSelectViewController ()

@end

@implementation FunctionSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tackCapture:(id)sender
{
    VideoRecordViewController *captureVC = [[VideoRecordViewController alloc]initWithNibName:@"VideoRecordViewController" bundle:nil];
    [captureVC setTitle:@"拍摄视频"];
    [self.navigationController pushViewController:captureVC animated:YES];
}
- (IBAction)editPicture:(id)sender {
   
    
}
//- (IBAction)takeMovie:(id)sender
//{
//    VideoRecordViewController *captureVC = [[VideoRecordViewController alloc]initWithNibName:@"VideoRecordViewController" bundle:nil];
//    [captureVC setTitle:@"拍摄视频"];
//    captureVC.captureFilterShouldApplyToWriter = YES;
//    [self.navigationController pushViewController:captureVC animated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
