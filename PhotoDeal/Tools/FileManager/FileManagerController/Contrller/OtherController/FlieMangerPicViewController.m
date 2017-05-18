//
//  FlieMangerPicViewController.m
//  PhotoDeal
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import "FlieMangerPicViewController.h"
#import "FileManagerTableView.h"
#import "FileManger.h"
#import "FileManagerCollectionView.h"

@interface FlieMangerPicViewController ()

@property (nonatomic, strong) FileManagerCollectionView *fileCollectionView;

@end

@implementation FlieMangerPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.picType) {
        self.picType = @"0";
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 4;
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    FileManagerCollectionView *fileCollectionView = [[FileManagerCollectionView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight - 64 - 41) collectionViewLayout:layout];
    
    [self.view addSubview:fileCollectionView];
    _fileCollectionView = fileCollectionView;
    
    NSArray *array;
    
    if ([self.picType isEqualToString:@"0"]) {//本机(iphone)视频
        array = [[FileManger shareInit] readLocalMachinePic];
 
    }else {
        array = [[FileManger shareInit] getSdWebImageArr];
    }
    
    self.fileCollectionView.dataArray = array;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
