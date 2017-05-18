//
//  FileManagerCollectionViewCell.h
//  PhotoDeal
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocalPicModel, TZAssetModel;
@interface FileManagerCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) LocalPicModel *model;

@property (nonatomic, strong) TZAssetModel *model1;

@property (nonatomic, assign) BOOL          isSelected;

//- (void)setSelected:(BOOL)isSelected;

@end
