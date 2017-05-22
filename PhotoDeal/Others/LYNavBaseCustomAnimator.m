//
//  LYNavBaseCustomAnimator.m
//  LYCustomTransitionDemo
//
//  Created by liyang on 2017/2/22.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "LYNavBaseCustomAnimator.h"

@implementation LYNavBaseCustomAnimator
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    fromView.frame = CGRectMake(0, 0, KWidth, KHeight);
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    toView.frame = CGRectMake(0, 0, KWidth, KHeight);
    
    //此处判断是push，还是pop 操作
    BOOL isPush = ([toViewController.navigationController.viewControllers indexOfObject:toViewController] > [fromViewController.navigationController.viewControllers indexOfObject:fromViewController]);
    
    if (isPush) {
        [containerView addSubview:fromView];
        [containerView addSubview:toView];//push,这里的toView 相当于secondVC的view
        toView.frame = CGRectMake(KWidth, KHeight, KWidth, KHeight);
    
    }else{
        [containerView addSubview:toView];
        [containerView addSubview:fromView];//pop,这里的fromView 也是相当于secondVC的view
        fromView.frame = CGRectMake(0, 0, KWidth, KHeight);
    }
    //因为secondVC的view在firstVC的view之上，所以要后添加到containerView中
    
    //动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (isPush) {
            toView.frame = CGRectMake(0, 0, KWidth, KHeight);
        }else{
            fromView.frame = CGRectMake(KWidth, KHeight, KWidth, KHeight);
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        //设置transitionContext通知系统动画执行完毕
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
