//
//  FileManagerCollectionView.h
//  PhotoDeal
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FileManagerCollectionView : UICollectionView

@property (copy) void (^selectedCollectionViewBlock)(NSIndexPath *indexpath , id data);

@property (nonatomic, strong) NSArray *dataArray;

@end
