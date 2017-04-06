//
//  VideoRecordViewController.h
//  GPUImageDemo
//
//  Created by 张浩 on 2017/3/30.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VideoRecordViewController : UIViewController

/*
 default is no
 选择的取景器滤镜是否要被apply到文件中
 
 如果设置yes，在拍摄界面选择的滤镜将直接写入到文件中，那么在视频编辑页面将无法撤销这些滤镜（更快的写入，拍摄即所得）
 设置no 则可以在视频编辑页面看到拍摄界面选择的滤镜并且可以对这些滤镜进行更改（更灵活的滤镜定义）
 */
@property(nonatomic, assign) BOOL captureFilterShouldApplyToWriter;


@end
