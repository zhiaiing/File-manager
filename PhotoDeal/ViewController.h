//
//  ViewController.h
//  PhotoDeal
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"

@interface ViewController : UIViewController{
    
    //显示的效果图
    GPUImageView *view1;
    
   
    
    
    
    GPUImageStillCamera *stillCamera;
    
  //  GPUImageStillCamera *stillCamera;
    
  //  GPUImageOutput<GPUImageInput> *filter, *secondFilter, *terminalFilter;
    
  //  GPUImagePicture *memoryPressurePicture1, *memoryPressurePicture2;
}

@end

