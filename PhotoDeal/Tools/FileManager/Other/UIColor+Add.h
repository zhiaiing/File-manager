//
//  UIColor+Add.h
//  PhotoDeal
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Add)

/**
 *  获取16进制字符串的颜色
 *
 *  @param color 0XFFFFFF or #FFFFFF or FFFFFF
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexStrings:(NSString *)color withAlpha:(NSString *)alpha;


+ (UIColor *)colorWithHex:(NSString *)string;


@end
