//
//  FileMangerVideoViewController.h
//  PhotoDeal
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 lanxiao. All rights reserved.
//  视频的控制器

#import <UIKit/UIKit.h>

@interface FileMangerVideoViewController : BaseViewController

// 0 本机视频   1 app沙盒里的视频 默认为0  2 本机音乐  3 沙盒的音乐 4 沙盒的word 5 沙盒的其他 6 app的文档 7 app的其他
@property (nonatomic, strong) NSString *picType;

@end
