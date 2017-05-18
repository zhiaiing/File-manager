//
//  PopView.h
//  PhotoDeal
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopView : UIView

@property (copy) void (^clickBtnBlock)(UIButton *dic, NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame andMaxframe:(CGRect )maxFrame;

- (void)startAnimation;

- (void)endAnimation;


@end
