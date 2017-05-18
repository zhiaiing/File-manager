//
//  ViewController.m
//  PhotoDeal
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 lanxiao. All rights reserved.
//  复古   反色

#import "ViewController.h"
#import "SDAutoLayout.h"

@interface ViewController ()

//调整亮度
@property (nonatomic, strong) UISlider  *brightnessSlider;

@property (nonatomic, strong) UISlider  *slider1;

@property (nonatomic, strong) UISlider  *slider2;

@property (nonatomic, strong) UISlider  *slider3;

@property (nonatomic, strong) UISlider  *slider4;

//显示的视图
@property (nonatomic,strong)    GPUImageView                        *filterImageView;

//复古滤镜
@property (nonatomic,strong)    GPUImageOutput<GPUImageInput>       *filter;

//反色
@property (nonatomic,strong)    GPUImageColorInvertFilter           *colorInvertFilter;

//灰度
@property (nonatomic,strong)    GPUImageGrayscaleFilter             *grayscaleFilter;




//亮度滤镜  -1.0 ~ 1.0      0.0
@property (nonatomic,strong)    GPUImageBrightnessFilter            *brightnessFilter;

//曝光滤镜  -10.0 ~ 10.0    0.0
@property (nonatomic,strong)    GPUImageExposureFilter              *exposureFilter;

//对比度   0.0 ~ 4.0        1.0
@property (nonatomic,strong)    GPUImageContrastFilter              *contrastFilter;

//饱和度   -0.0 ~ 2.0       1.0
@property (nonatomic,strong)    GPUImageSaturationFilter            *saturationFilter;

//伽马线   -0.0 ~ 3.0       1.0
@property (nonatomic,strong)    GPUImageGammaFilter                 *gammaFilter;

//RGB
@property (nonatomic,strong)    GPUImageRGBFilter                   *rGBFilter;

//不透明度  0.0 - 1.0       1.0
@property (nonatomic,strong)    GPUImageOpacityFilter               *opacityFilter;

//提亮阴影 0 - 1, increase to lighten shadows   0 - 1, decrease to darken highlights.
@property (nonatomic,strong)    GPUImageHighlightShadowFilter       *highlightShadowFilter;

//色度
@property (nonatomic,strong)    GPUImageHueFilter                   *hueFilter;

//白平衡
@property (nonatomic,strong)    GPUImageWhiteBalanceFilter          *whiteBalanceFilte;

//像素色值亮度平均，图像黑白（有类似漫画效果）                   1.0
@property (nonatomic,strong)    GPUImageAverageLuminanceThresholdFilter             *averageLuminanceThresholdFilter;

//lookup 色彩调整  0.0 - 1.0      1.0
@property (nonatomic,strong)    GPUImageLookupFilter                *lookupFilter;






//色阶
@property (nonatomic,strong)    GPUImageLevelsFilter                *levelsFilter;

//色彩直方图，显示在图片上
@property (nonatomic,strong)    GPUImageHistogramFilter             *histogramFilter;

//色彩直方图
@property (nonatomic,strong)    GPUImageHistogramGenerator          *histogramGenerator;

//色调曲线
@property (nonatomic,strong)    GPUImageToneCurveFilter             *toneCurveFilter;

//单色
@property (nonatomic,strong)    GPUImageMonochromeFilter            *monochromeFilter;

//色彩替换（替换亮部和暗部色彩）
@property (nonatomic,strong)    GPUImageFalseColorFilter            *falseColorFilter;

//色度键
@property (nonatomic,strong)    GPUImageChromaKeyFilter             *chromaKeyFilter;

//像素平均色值
@property (nonatomic,strong)    GPUImageAverageColor                *averageColor;

//纯色
@property (nonatomic,strong)    GPUImageSolidColorGenerator         *solidColorGenerator;

//亮度平均
@property (nonatomic,strong)    GPUImageLuminosity                  *luminosity;








//Amatorka lookup
@property (nonatomic,strong)    GPUImageAmatorkaFilter             *amatorkaFilter;

//MissEtikate lookup
@property (nonatomic,strong)    GPUImageMissEtikateFilter          *missEtikateFilter;

//SoftElegance lookup
@property (nonatomic,strong)    GPUImageSoftEleganceFilter         *softEleganceFilter;




//高斯模糊
@property (nonatomic,strong)    GPUImageGaussianBlurFilter              *gaussianBlurFilter;

//动作检测
@property (nonatomic, strong)   GPUImageMotionDetector                  *motionDetector;





//高斯模糊
@property (nonatomic,strong)    GPUImageGaussianSelectiveBlurFilter     *gaussianSelectiveBlurFilter;

//卡通效果（黑色粗线描边)
@property (nonatomic, strong)   GPUImageToonFilter                      *toonFilter;

//强光混合,通常用于创建阴影效果
@property (nonatomic, strong)   GPUImageHardLightBlendFilter            *hardLightBlendFilter;

//素描
@property (nonatomic, strong)   GPUImageSketchFilter                    *imageSketchFilter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(200, 200, 60, 60);
    [btn addTarget:self action:@selector(bbb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)aaa:(UISlider *)slider{
    
    if(slider.tag == 0){//调整亮度
        self.brightnessFilter.brightness = slider.value;
    }
}

- (void)bbb{
    // 截取某一时刻的滤镜图片
    [stillCamera capturePhotoAsImageProcessedUpToFilter:self.filter withCompletionHandler:^(UIImage *processedImage, NSError *error) {

        NSLog(@"=========== %@",error);
        // 耗内存
   //     NSData *dataForJPEGFile = UIImageJPEGRepresentation(processedImage, 0.8);
        
        UIImageWriteToSavedPhotosAlbum(processedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
        
//        // 保存到Document
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        
//        NSError *error2 = nil;
//        if (![dataForJPEGFile writeToFile:[documentsDirectory stringByAppendingPathComponent:@"FilteredPhoto.jpg"] options:NSAtomicWrite error:&error2])
//        {
//            if (error2) {
//                NSLog(@"%@",error2);
//            }else{
//                NSLog(@"asdsadqw");
//                [stillCamera stopCameraCapture];
//                [stillCamera startCameraCapture];
//            }
//            //return;
//        }
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}



- (void)loadView{
    
    CGRect mainScreenFrame      = [[UIScreen mainScreen] applicationFrame];
    UIView *primaryView         = [[UIView alloc] initWithFrame:mainScreenFrame];
    primaryView.backgroundColor = [UIColor blueColor];
    self.view = primaryView;
    
    stillCamera     = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
   // view1           = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:view1];
    
    
    [self addFilter:stillCamera];
    
    [self addTargets];
    
    // 开始捕获
    [stillCamera startCameraCapture];

}

//初始化并添加 滤镜
- (void)addFilter:(GPUImageStillCamera *)stillCameras{
    // 初始化滤镜
    self.filter = [[GPUImageSepiaFilter alloc] init];
    
    //亮度
    self.brightnessFilter      = [[GPUImageBrightnessFilter alloc]init];
    self.brightnessFilter.brightness      = 0;
    
    //曝光滤镜
    self.exposureFilter = [[GPUImageExposureFilter alloc]init];
    self.exposureFilter.exposure = 0;
    
    //灰度
   // self.grayscaleFilter        = [[GPUImageGrayscaleFilter alloc]init];
    
    //反色
    //self.colorInvertFilter      = [[GPUImageColorInvertFilter alloc]init];
    
    self.imageSketchFilter             = [[GPUImageSketchFilter alloc]init];
  
    // 添加滤镜
    [stillCameras addTarget:_brightnessFilter];
    
    [stillCameras addTarget:self.filter];

}



// 添加滤镜显示视图
- (void)addTargets{
    // 添加滤镜显示视图
    self.filterImageView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.filterImageView];
    
    [self.brightnessFilter addTarget:self.filterImageView];
    [self.filter addTarget:self.filterImageView];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}










@end
