//
//  BaseAnimateViewController.m
//  PhotoDeal
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import "BaseAnimateViewController.h"
#import "LYNavBaseCustomAnimator.h"

@interface BaseAnimateViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) LYNavBaseCustomAnimator *customAnimator;

@end

@interface BaseAnimateViewController ()

@end

@implementation BaseAnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1. 设置代理
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        return self.customAnimator;
        
    }else if (operation == UINavigationControllerOperationPop){
        return self.customAnimator;
    }
    return nil;
}

- (LYNavBaseCustomAnimator *)customAnimator{
    if (_customAnimator == nil) {
        _customAnimator = [[LYNavBaseCustomAnimator alloc]init];
    }
    return _customAnimator;
}


@end
