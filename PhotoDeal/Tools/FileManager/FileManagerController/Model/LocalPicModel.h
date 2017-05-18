//
//  LocalPicModel.h
//  PhotoDeal
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalPicModel : NSObject

@property (nonatomic, strong) NSString *fileName;

@property (nonatomic, strong) NSString *filePath;

//文件的类型 pic video word pdf other
@property (nonatomic, strong) NSString *fileType;

@property (nonatomic, assign) BOOL isSelected;

@end
