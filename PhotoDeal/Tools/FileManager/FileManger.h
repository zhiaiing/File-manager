//
//  FileManger.h
//  PhotoDeal
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManger : NSObject

//初始化
+ (instancetype)shareInit;


//此iphone设置上的数据
//获取本机图片
- (NSArray *)readLocalMachinePic;

//获取本机视频
- (NSArray *)readLocalMachineVideo;

//获取本机音乐
- (NSArray *)readLocalMachineMusic;



//该APP沙盒里的数据
//获取SDWebImage 里缓存的图片信息
- (NSArray *)getSdWebImageArr;

//获取沙盒里的视频
- (NSArray *)readSandBoxVideo;

//获取沙盒里的音乐
- (NSArray *)readSandBoxMusic;

//获取沙盒里的Word文件
- (NSArray *)readSandBoxWord;

//获取沙盒里的其他文件
- (NSArray *)readSandBoxOtherFile;

@end
