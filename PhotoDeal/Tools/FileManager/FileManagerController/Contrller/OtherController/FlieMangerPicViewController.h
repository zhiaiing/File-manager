//
//  FlieMangerPicViewController.h
//  PhotoDeal
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 lanxiao. All rights reserved.
//  图片

#import <UIKit/UIKit.h>

@interface FlieMangerPicViewController : BaseViewController

// 0 本机(iphone)图片   1 app沙盒里的图片(SDWebImage) 默认为0
@property (nonatomic, strong) NSString *picType;

@end
