//
//  VideoRecordViewController.m
//  GPUImageDemo
//
//  Created by 张浩 on 2017/3/30.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "VideoRecordViewController.h"
#import  <MediaPlayer/MediaPlayer.h>
#import "FilterAddView.h"

@interface VideoRecordViewController ()<FilterAddViewDelegate>

//取景
@property (nonatomic, strong) GPUImageView *playerView;
//滤镜选择操作界面
@property (nonatomic, strong) FilterAddView *filterAddView;

//拍摄操作对象input
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
//摄像头
@property (nonatomic, assign) AVCaptureDevicePosition devicePosition;

//文件写入对象 outPut
@property (nonatomic, strong) GPUImageMovieWriter *movieWriter;

//是否是在录制
@property (nonatomic, assign) BOOL isRecording;
//所有拍摄片段
@property (nonatomic, strong) NSMutableArray<AVAsset *> *assets;

//全部的录制结果，如果有暂停继续录制，返回的是AVMutableComposition对象（为了支持录制暂停继续录制  我也是醉了）
@property (nonatomic, strong, readonly) AVAsset *recordAsset;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *slider;

//当前片段的文件路径
@property (nonatomic, strong)NSString *currentRecordFileUrl;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;

//合成所有片段的队列
@property (nonatomic, retain) dispatch_queue_t videoEditQueue;

@end

@implementation VideoRecordViewController
{
    NSString *_resultFileUrl;
    GPUImageMovie *_resourceMovie;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self startStop];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.videoCamera startCameraCapture];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoEditQueue = dispatch_queue_create("GPUImageVideoEditeQueue", nil);
    
    //初始化view
    [self initViews];
    //初始化为后置摄像头
    self.devicePosition = AVCaptureDevicePositionBack;
    //初始化拍摄环境
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:self.devicePosition];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = NO;
    self.videoCamera.horizontallyMirrorRearFacingCamera = NO;
    [self.videoCamera addTarget:self.playerView];
}

-(void)initViews
{
    [self.view addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.equalTo(self.playerView.mas_width);
    }];
    [self.view addSubview:self.filterAddView];
    [self.filterAddView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.btnPlay.mas_top);
        make.top.equalTo(self.playerView.mas_bottom);
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"录制" style:UIBarButtonItemStylePlain target:self action:@selector(startStop)];
}

-(void)startStop
{
    if (self.isRecording)
    {
        self.navigationItem.rightBarButtonItem.title = @"录制";
        [self.videoCamera removeTarget:self.movieWriter];
        [self.movieWriter finishRecordingWithCompletionHandler:^{
            NSLog(@"文件写入完成");
            [self.assets addObject:[AVAsset assetWithURL:[NSURL fileURLWithPath:self.currentRecordFileUrl]]];
            self.movieWriter = nil;
        }];
    }
    else
    {
        self.navigationItem.rightBarButtonItem.title = @"暂停";
        [self restartWriter];
        [self applyAllFiltersBetweenOutPut:self.videoCamera andInPut:self.movieWriter];
        [((FilterObject *)self.filterAddView.allFilters.lastObject).filter addTarget:self.playerView];
        [self.movieWriter startRecording];
    }
    self.isRecording = !self.isRecording;
}

//写入新的片段
-(void)restartWriter
{
    NSString *fileName = [NSString stringWithFormat:@"%.f.mp4",[[NSDate date] timeIntervalSince1970]];
    self.currentRecordFileUrl = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",fileName]];
    unlink([self.currentRecordFileUrl UTF8String]);
    NSURL *movieURL = [NSURL fileURLWithPath:self.currentRecordFileUrl];
    self.movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 480)];//保证和取景框的分辨率保持一致（伪实现摄像头分辨率的自定义- -！）
    self.movieWriter.assetWriter.shouldOptimizeForNetworkUse = YES;
    if (!self.assets)
    {
        self.assets = [NSMutableArray array];
    }
    self.videoCamera.audioEncodingTarget = self.movieWriter;
    [self applyAllFiltersBetweenOutPut:self.videoCamera andInPut:self.movieWriter];
}

//不使用滤镜
- (IBAction)saveToAlbum:(id)sender
{
    if (self.isRecording) {
        [self startStop];
    }
    [self.videoCamera stopCameraCapture];
    
    _resourceMovie = [[GPUImageMovie alloc]initWithAsset:self.recordAsset];
    NSString *fileName = [NSString stringWithFormat:@"%.f.mp4",[[NSDate date] timeIntervalSince1970]];
    _resultFileUrl = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",fileName]];
    unlink([_resultFileUrl UTF8String]);
    NSURL *movieURL = [NSURL fileURLWithPath:_resultFileUrl];
    GPUImageMovieWriter *movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 480)];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.3f
                                                      target:self
                                                    selector:@selector(retrievingProgress)
                                                    userInfo:nil
                                                     repeats:YES];
    movieWriter.shouldPassthroughAudio = YES;
    _resourceMovie.audioEncodingTarget = movieWriter;
    [_resourceMovie enableSynchronizedEncodingUsingMovieWriter:movieWriter];

    [_resourceMovie addTarget:movieWriter];
    [movieWriter startRecording];
    [_resourceMovie startProcessing];

    __weak GPUImageMovie *weakResourceMovie = _resourceMovie;
    __weak GPUImageMovieWriter *weakMovieWriter = movieWriter;
    __weak NSTimer *weakTimer = timer;
    __weak NSString *weakurl = _resultFileUrl;
    [movieWriter setCompletionBlock:^{
        [weakResourceMovie removeAllTargets];
        [weakMovieWriter finishRecording];
        [weakTimer invalidate];
        UISaveVideoAtPathToSavedPhotosAlbum(weakurl, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    }];
}

- (void)retrievingProgress
{
    NSLog(@"%d%%",(int)(_resourceMovie.progress * 100));
}



- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo: (void *) contextInfo
{
    NSError *errors = nil;
    for (AVURLAsset *asset in self.assets) {
        [[NSFileManager defaultManager]removeItemAtPath:asset.URL.path error:&errors];
    }
    [[NSFileManager defaultManager]removeItemAtPath:_resultFileUrl error:&errors];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频文件已保存到相册" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma mark
#pragma mark apply滤镜
//在输出端和输入端中间加上所有的滤镜
- (void)applyAllFiltersBetweenOutPut:(GPUImageOutput *)outPut andInPut:(id<GPUImageInput>)input
{
    for (FilterObject *obj in self.filterAddView.allFilters) {
        [obj.filter removeAllTargets];
    }
    if (self.filterAddView.allFilters.count>0)
    {
        GPUImageOutput *tempOutPut = outPut;//墙上的插口
        for (int i = 0;i<self.filterAddView.allFilters.count;i++)//插排插，插排插，插排插，插排插
        {
            FilterObject *obj = self.filterAddView.allFilters[i];
            [tempOutPut addTarget:obj.filter];
            tempOutPut = obj.filter;
        }
        [tempOutPut addTarget:input];//插充电器
    }
    else
    {
        [outPut addTarget:input];
    }
}



#pragma mark
#pragma mark filterAddViewDelegate
-(UINavigationController *)filterAddViewNavigationController;
{
    return self.navigationController;
}

-(void)filterAddView:(FilterAddView *)view hasChangedFilterValue:(FilterObject *)obj
{
    // do noting  
}

-(void)filterAddView:(FilterAddView *)view addNewFilter:(FilterObject *)obj
{
    [self.videoCamera removeAllTargets];
    //取景器添加滤镜，添加、删除都需要重新设置滤镜输入输出关系
    [self applyAllFiltersBetweenOutPut:self.videoCamera andInPut:self.playerView];
}

-(void)filterAddView:(FilterAddView *)view deleteFilter:(FilterObject *)obj
{
    [self.videoCamera stopCameraCapture];
    [self.videoCamera removeAllTargets];
    //取景器添加滤镜，添加、删除都需要重新设置滤镜输入输出关系
    [self applyAllFiltersBetweenOutPut:self.videoCamera andInPut:self.playerView];
    [self.videoCamera startCameraCapture];
}



#pragma mark
#pragma mark getter

-(GPUImageView *)playerView
{
    if (!_playerView) {
        _playerView = [[GPUImageView alloc]init];
        _playerView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    }
    return _playerView;
}

-(AVAsset *)recordAsset
{
    __block AVAsset *asset = nil;
    __weak VideoRecordViewController *weakSelf = self;
    
    dispatch_sync(self.videoEditQueue, ^{
        if (weakSelf.assets.count == 1) {
            asset = weakSelf.assets.firstObject;
        } else {
            AVMutableComposition *composition = [AVMutableComposition composition];
            [self appendSegmentsToComposition:composition];
            asset = composition;
        }
    });
    return asset;
}

-(FilterAddView *)filterAddView
{
    if (!_filterAddView) {
        _filterAddView = [[FilterAddView alloc]init];;
        _filterAddView.delegate = self;
    }
    return _filterAddView;
}


#pragma mark
#pragma mark tools
- (void)appendSegmentsToComposition:(AVMutableComposition * __nonnull)composition {
    [self appendSegmentsToComposition:composition audioMix:nil];
}

- (void)appendSegmentsToComposition:(AVMutableComposition *)composition audioMix:(AVMutableAudioMix *)audioMix {
    AVMutableCompositionTrack *audioTrack = nil;
    AVMutableCompositionTrack *videoTrack = nil;
    
    int currentSegment = 0;
    CMTime currentTime = composition.duration;
    for (AVAsset *asset in self.assets) {
        
        NSArray *audioAssetTracks = [asset tracksWithMediaType:AVMediaTypeAudio];
        NSArray *videoAssetTracks = [asset tracksWithMediaType:AVMediaTypeVideo];
        
        CMTime maxBounds = kCMTimeInvalid;
        
        CMTime videoTime = currentTime;
        for (AVAssetTrack *videoAssetTrack in videoAssetTracks)
        {
            if (videoTrack == nil)
            {
                NSArray *videoTracks = [composition tracksWithMediaType:AVMediaTypeVideo];
                if (videoTracks.count > 0)
                {
                    videoTrack = [videoTracks firstObject];
                }
                else
                {
                    videoTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
                    videoTrack.preferredTransform = videoAssetTrack.preferredTransform;
                }
            }
            
            videoTime = [self _appendTrack:videoAssetTrack toCompositionTrack:videoTrack atTime:videoTime withBounds:maxBounds];
            maxBounds = videoTime;
        }
        CMTime audioTime = currentTime;
        for (AVAssetTrack *audioAssetTrack in audioAssetTracks)
        {
            if (audioTrack == nil)
            {
                NSArray *audioTracks = [composition tracksWithMediaType:AVMediaTypeAudio];
                
                if (audioTracks.count > 0)
                {
                    audioTrack = [audioTracks firstObject];
                }
                else
                {
                    audioTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
                }
            }
            audioTime = [self _appendTrack:audioAssetTrack toCompositionTrack:audioTrack atTime:audioTime withBounds:maxBounds];
        }
        currentTime = composition.duration;
        currentSegment++;
    }
}

- (CMTime)_appendTrack:(AVAssetTrack *)track toCompositionTrack:(AVMutableCompositionTrack *)compositionTrack atTime:(CMTime)time withBounds:(CMTime)bounds {
    CMTimeRange timeRange = track.timeRange;
    time = CMTimeAdd(time, timeRange.start);
    
    if (CMTIME_IS_VALID(bounds)) {
        CMTime currentBounds = CMTimeAdd(time, timeRange.duration);
        
        if (CMTIME_COMPARE_INLINE(currentBounds, >, bounds)) {
            timeRange = CMTimeRangeMake(timeRange.start, CMTimeSubtract(timeRange.duration, CMTimeSubtract(currentBounds, bounds)));
        }
    }
    
    if (CMTIME_COMPARE_INLINE(timeRange.duration, >, kCMTimeZero)) {
        NSError *error = nil;
        [compositionTrack insertTimeRange:timeRange ofTrack:track atTime:time error:&error];
        
        if (error != nil) {
            NSLog(@"Failed to insert append %@ track: %@", compositionTrack.mediaType, error);
        } else {
            //        NSLog(@"Inserted %@ at %fs (%fs -> %fs)", track.mediaType, CMTimeGetSeconds(time), CMTimeGetSeconds(timeRange.start), CMTimeGetSeconds(timeRange.duration));
        }
        
        return CMTimeAdd(time, timeRange.duration);
    }
    
    return time;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
