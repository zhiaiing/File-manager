//
//  BaseViewController.m
//  PhotoDeal
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import "BaseViewController1.h"
#import "YALTabBarItem.h"
#import "YALAnimatingTabBarConstants.h"
#import "POP.h"
#import "PopView.h"
#import "FileManger.h"
#import "UIImageView+WebCache.h"
#import "FileManagerViewController.h"
#import "LocalPicModel.h"
#import "TZAssetModel.h"
#import "FileMangerController.h"
#import "ViewController.h"
#import "BaseAnimateViewController.h"

@interface BaseViewController1 ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BaseViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    

    ViewController *viewController1 = [[ViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:viewController1];
    viewController1.title = @"111";
    
    
    FileManagerViewController *viewController2 = [[FileManagerViewController alloc]init];
    BaseAnimateViewController *nav2 = [[BaseAnimateViewController alloc]initWithRootViewController:viewController2];
    viewController2.title = @"222";
    
    
    FileMangerController *viewController3 = [[FileMangerController alloc]init];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:viewController3];
    viewController3.title = @"333";
    
    self.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nil];
    

    PopView *popView = [[PopView alloc]initWithFrame:CGRectMake(KWidth - 40, KHeight - 40, 40, 40) andMaxframe:CGRectMake(KWidth - 140, KHeight  - 140, 140, 140)];
    [self.view addSubview:popView];
    
   
    popView.clickBtnBlock = ^(UIButton *btn, NSInteger index) {
        
        if (index == 0) {
            
            if (btn.selected) {  
                [popView startAnimation];
            }else{
                
                [popView endAnimation];
            }
        }else{
            [popView endAnimation];
            
            self.selectedIndex = index-1;
        }        
    };

    self.selectedIndex = 1;
    
   
    
//    NSMutableArray *array = [NSMutableArray array];
//    [array addObject:@"http://d.hiphotos.baidu.com/zhidao/pic/item/72f082025aafa40fe871b36bad64034f79f019d4.jpg"];
//    [array addObject:@"http://f.hiphotos.baidu.com/zhidao/pic/item/8b82b9014a90f60326b707453b12b31bb051eda9.jpg"];
//    [array addObject:@"http://f.hiphotos.baidu.com/zhidao/pic/item/902397dda144ad3464639dc8d1a20cf430ad85a4.jpg"];
//    [array addObject:@"http://r002.joyme.com/r002/image/2012/07/87/FA8321B09723D23088307493EE22D708.jpg"];
//
//
//    for (NSString *str in array) {
//        UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 80, 80)];
//        imageView2.backgroundColor = [UIColor redColor];
//        [imageView2 sd_setImageWithURL:[NSURL URLWithString:str]];
//        [self.view addSubview:imageView2];
//    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
