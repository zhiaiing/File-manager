//
//  FileManagerViewController.m
//  PhotoDeal
//
//  Created by mac on 2017/5/12.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import "FileManagerViewController.h"
#import "FileManagerTableView.h"
#import "FileManger.h"
#import "FileManagerCollectionView.h"


@interface FileManagerViewController ()//<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//@property (nonatomic, strong) UICollectionView *collectionView;

//@property (nonatomic, strong) FileManagerTableView *fileTableView;

@property (nonatomic, strong) FileManagerCollectionView *fileCollectionView;

@end

@implementation FileManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  //  NSArray *array = [[FileManger shareInit] getSdWebImageArr];
    
    NSArray *array = [[FileManger shareInit] readLocalMachineVideo];
    
    
    [[FileManger shareInit] readLocalMachineMusic];
    
//    _fileTableView = [[FileManagerTableView alloc]init];
//    _fileTableView.frame = CGRectMake(0, 0, 375, 667 - 64);
//    _fileTableView.dataArray = array;
//    [self.view addSubview:_fileTableView];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 4;
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    FileManagerCollectionView *fileCollectionView = [[FileManagerCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 667) collectionViewLayout:layout];

    fileCollectionView.dataArray = array;
    
    [self.view addSubview:fileCollectionView];
    _fileCollectionView = fileCollectionView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
