//
//  FileMangerVideoViewController.m
//  PhotoDeal
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import "FileMangerVideoViewController.h"
#import "FlieManagerTableView.h"
#import "FileManger.h"
#import "FileManagerCollectionView.h"

@interface FileMangerVideoViewController ()

@end

@implementation FileMangerVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.picType) {
        self.picType = @"0";
    }
    
    NSArray *array;
    
    FlieManagerTableView *tableview = [[FlieManagerTableView alloc]init];
    tableview.frame = CGRectMake(0, 0, KWidth,KHeight - 64 - 41);
    
    [self.view addSubview:tableview];
    
    
//    if ([self.picType isEqualToString:@"0"]) {
//        array = [[FileManger shareInit] readLocalMachineVideo];
//    }else if ([self.picType isEqualToString:@"1"]){
//        array = [NSArray array];
//    }else{
//        array = [[FileManger shareInit] readLocalMachineMusic];
//    }
    
    // 0 本机(iphone)视频   1 沙盒里的视频 默认为0  2 本机(iphone)音乐  3 沙盒的音乐 4 沙盒的word 5 沙盒的其他 6 本机(iphone)的文档 7 本机(iphone)的其他
    
    if ([self.picType isEqualToString:@"0"]) {//本机(iphone)视频
        array = [[FileManger shareInit] readLocalMachineVideo];
        
        
    }else if ([self.picType isEqualToString:@"1"]){// 沙盒里的视频
        array = [[FileManger shareInit] readSandBoxVideo];
        
        
    }else if ([self.picType isEqualToString:@"2"]){//本机(iphone)音乐
        array = [[FileManger shareInit] readLocalMachineMusic];
        
        
    }else if ([self.picType isEqualToString:@"3"]){//沙盒的音乐
        array = [[FileManger shareInit] readSandBoxMusic];
        
        
    }else if ([self.picType isEqualToString:@"4"]){//沙盒的word
        array = [[FileManger shareInit] readSandBoxWord];
        
        
    }else if ([self.picType isEqualToString:@"5"]){//沙盒的其他
        array = [[FileManger shareInit] readSandBoxOtherFile];
        
        
    }else if ([self.picType isEqualToString:@"6"]){//本机(iphone)的文档
        array = [NSArray array];
        
        
    }else if ([self.picType isEqualToString:@"7"]){//本机(iphone)的其他
        array = [NSArray array];
        
    }else {
        array = [NSArray array];
    }
    
    tableview.dataArray = array;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
