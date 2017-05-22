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


@interface FileManagerViewController ()<UINavigationControllerDelegate>//<UIImagePickerControllerDelegate, UINavigationControllerDelegate>




//@property (nonatomic, strong) UICollectionView *collectionView;

//@property (nonatomic, strong) FileManagerTableView *fileTableView;

@property (nonatomic, strong) FileManagerCollectionView *fileCollectionView;

@end

@implementation FileManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *array = [[FileManger shareInit] readLocalMachineVideo];
    
    [[FileManger shareInit] readLocalMachineMusic];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 4;
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    FileManagerCollectionView *fileCollectionView = [[FileManagerCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 667) collectionViewLayout:layout];

    fileCollectionView.dataArray = array;
    
    [self.view addSubview:fileCollectionView];
    _fileCollectionView = fileCollectionView;
    
    
    fileCollectionView.selectedCollectionViewBlock = ^(NSIndexPath *indexpath, id data) {
        BaseViewController *vc      = [BaseViewController new];
        vc.view.backgroundColor     = [UIColor redColor];
        //UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self.navigationController pushViewController:vc animated:YES];

//        [self presentViewController:nav animated:YES completion:^{
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [vc dismissViewControllerAnimated:YES completion:nil];
//            });
//        }];
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 10;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


@end
