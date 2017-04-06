//
//  transform.h
//  GPUImageDemo
//
//  Created by 张浩 on //.
//  Copyright © 年 张浩. All rights reserved.
//

#ifndef transform_h
#define transform_h

GPUImageBrightnessFilter.h                //亮度
GPUImageExposureFilter.h                  //曝光
GPUImageContrastFilter.h                  //对比度
GPUImageSaturationFilter.h                //饱和度
GPUImageGammaFilter.h                     //伽马线
GPUImageColorInvertFilter.h               //反色
GPUImageSepiaFilter.h                     //褐色（怀旧）
GPUImageLevelsFilter.h                    //色阶
GPUImageGrayscaleFilter.h                 //灰度
GPUImageHistogramFilter.h                 //色彩直方图，显示在图片上
GPUImageHistogramGenerator.h              //色彩直方图
GPUImageRGBFilter.h                       //RGB
GPUImageToneCurveFilter.h                 //色调曲线
GPUImageMonochromeFilter.h                //单色
GPUImageOpacityFilter.h                   //不透明度
GPUImageHighlightShadowFilter.h           //提亮阴影
GPUImageFalseColorFilter.h                //色彩替换（替换亮部和暗部色彩）
GPUImageHueFilter.h                       //色度
GPUImageChromaKeyFilter.h                 //色度键
GPUImageWhiteBalanceFilter.h              //白平横
GPUImageAverageColor.h                    //像素平均色值
GPUImageSolidColorGenerator.h             //纯色
GPUImageLuminosity.h                      //亮度平均
GPUImageAverageLuminanceThresholdFilter.h //像素色值亮度平均，图像黑白（有类似漫画效果）

GPUImageLookupFilter.h                    //lookup 色彩调整
GPUImageAmatorkaFilter.h                  //Amatorka lookup
GPUImageMissEtikateFilter.h               //MissEtikate lookup
GPUImageSoftEleganceFilter.h              //SoftElegance lookup

#pragma mark - 图像处理 Handle Image

GPUImageCrosshairGenerator.h              //十字
GPUImageLineGenerator.h                   //线条

GPUImageTransformFilter.h                 //形状变化
GPUImageCropFilter.h                      //剪裁
GPUImageSharpenFilter.h                   //锐化
GPUImageUnsharpMaskFilter.h               //反遮罩锐化

GPUImageFastBlurFilter.h                  //模糊
GPUImageGaussianBlurFilter.h              //高斯模糊
GPUImageGaussianSelectiveBlurFilter.h     //高斯模糊，选择部分清晰
GPUImageBoxBlurFilter.h                   //盒状模糊
GPUImageTiltShiftFilter.h                 //条纹模糊，中间清晰，上下两端模糊
GPUImageMedianFilter.h                    //中间值，有种稍微模糊边缘的效果
GPUImageBilateralFilter.h                 //双边模糊
GPUImageErosionFilter.h                   //侵蚀边缘模糊，变黑白
GPUImageRGBErosionFilter.h                //RGB侵蚀边缘模糊，有色彩
GPUImageDilationFilter.h                  //扩展边缘模糊，变黑白
GPUImageRGBDilationFilter.h               //RGB扩展边缘模糊，有色彩
GPUImageOpeningFilter.h                   //黑白色调模糊
GPUImageRGBOpeningFilter.h                //彩色模糊
GPUImageClosingFilter.h                   //黑白色调模糊，暗色会被提亮
GPUImageRGBClosingFilter.h                //彩色模糊，暗色会被提亮
GPUImageLanczosResamplingFilter.h         //Lanczos重取样，模糊效果
GPUImageNonMaximumSuppressionFilter.h     //非最大抑制，只显示亮度最高的像素，其他为黑
GPUImageThresholdedNonMaximumSuppressionFilter.h //与上相比，像素丢失更多

GPUImageSobelEdgeDetectionFilter.h        //Sobel边缘检测算法(白边，黑内容，有点漫画的反色效果)
GPUImageCannyEdgeDetectionFilter.h        //Canny边缘检测算法（比上更强烈的黑白对比度）
GPUImageThresholdEdgeDetectionFilter.h    //阈值边缘检测（效果与上差别不大）
GPUImagePrewittEdgeDetectionFilter.h      //普瑞维特(Prewitt)边缘检测(效果与Sobel差不多，貌似更平滑)
GPUImageXYDerivativeFilter.h              //XYDerivative边缘检测，画面以蓝色为主，绿色为边缘，带彩色
GPUImageHarrisCornerDetectionFilter.h     //Harris角点检测，会有绿色小十字显示在图片角点处
GPUImageNobleCornerDetectionFilter.h      //Noble角点检测，检测点更多
GPUImageShiTomasiFeatureDetectionFilter.h //ShiTomasi角点检测，与上差别不大
GPUImageMotionDetector.h                  //动作检测
GPUImageHoughTransformLineDetector.h      //线条检测
GPUImageParallelCoordinateLineTransformFilter.h //平行线检测

GPUImageLocalBinaryPatternFilter.h        //图像黑白化，并有大量噪点

GPUImageLowPassFilter.h                   //用于图像加亮
GPUImageHighPassFilter.h                  //图像低于某值时显示为黑


#pragma mark - 视觉效果 Visual Effect

GPUImageSketchFilter.h                    //素描
GPUImageThresholdSketchFilter.h           //阀值素描，形成有噪点的素描
GPUImageToonFilter.h                      //卡通效果（黑色粗线描边）
GPUImageSmoothToonFilter.h                //相比上面的效果更细腻，上面是粗旷的画风
GPUImageKuwaharaFilter.h                  //桑原(Kuwahara)滤波,水粉画的模糊效果；处理时间比较长，慎用

GPUImageMosaicFilter.h                    //黑白马赛克
GPUImagePixellateFilter.h                 //像素化
GPUImagePolarPixellateFilter.h            //同心圆像素化
GPUImageCrosshatchFilter.h                //交叉线阴影，形成黑白网状画面
GPUImageColorPackingFilter.h              //色彩丢失，模糊（类似监控摄像效果）

GPUImageVignetteFilter.h                  //晕影，形成黑色圆形边缘，突出中间图像的效果
GPUImageSwirlFilter.h                     //漩涡，中间形成卷曲的画面
GPUImageBulgeDistortionFilter.h           //凸起失真，鱼眼效果
GPUImagePinchDistortionFilter.h           //收缩失真，凹面镜
GPUImageStretchDistortionFilter.h         //伸展失真，哈哈镜
GPUImageGlassSphereFilter.h               //水晶球效果
GPUImageSphereRefractionFilter.h          //球形折射，图形倒立

GPUImagePosterizeFilter.h                 //色调分离，形成噪点效果
GPUImageCGAColorspaceFilter.h             //CGA色彩滤镜，形成黑、浅蓝、紫色块的画面
GPUImagePerlinNoiseFilter.h               //柏林噪点，花边噪点
GPUImagexConvolutionFilter.h            //x卷积，高亮大色块变黑，加亮边缘、线条等
GPUImageEmbossFilter.h                    //浮雕效果，带有点d的感觉
GPUImagePolkaDotFilter.h                  //像素圆点花样
GPUImageHalftoneFilter.h                  //点染,图像黑白化，由黑点构成原图的大致图形


#pragma mark - 混合模式 Blend

GPUImageMultiplyBlendFilter.h             //通常用于创建阴影和深度效果
GPUImageNormalBlendFilter.h               //正常
GPUImageAlphaBlendFilter.h                //透明混合,通常用于在背景上应用前景的透明度
GPUImageDissolveBlendFilter.h             //溶解
GPUImageOverlayBlendFilter.h              //叠加,通常用于创建阴影效果
GPUImageDarkenBlendFilter.h               //加深混合,通常用于重叠类型
GPUImageLightenBlendFilter.h              //减淡混合,通常用于重叠类型
GPUImageSourceOverBlendFilter.h           //源混合
GPUImageColorBurnBlendFilter.h            //色彩加深混合
GPUImageColorDodgeBlendFilter.h           //色彩减淡混合
GPUImageScreenBlendFilter.h               //屏幕包裹,通常用于创建亮点和镜头眩光
GPUImageExclusionBlendFilter.h            //排除混合
GPUImageDifferenceBlendFilter.h           //差异混合,通常用于创建更多变动的颜色
GPUImageSubtractBlendFilter.h             //差值混合,通常用于创建两个图像之间的动画变暗模糊效果
GPUImageHardLightBlendFilter.h            //强光混合,通常用于创建阴影效果
GPUImageSoftLightBlendFilter.h            //柔光混合
GPUImageChromaKeyBlendFilter.h            //色度键混合
GPUImageMaskFilter.h                      //遮罩混合
GPUImageHazeFilter.h                      //朦胧加暗
GPUImageLuminanceThresholdFilter.h        //亮度阈
GPUImageAdaptiveThresholdFilter.h         //自适应阈值
GPUImageAddBlendFilter.h                  //通常用于创建两个图像之间的动画变亮模糊效果
GPUImageDivideBlendFilter.h               //通常用于创建两个图像之间的动画变暗模糊效果


#pragma mark - 尚不清楚
GPUImageJFAVoroniFilter.h
GPUImageVoroniConsumerFilter.h

#endif /* transform_h */
