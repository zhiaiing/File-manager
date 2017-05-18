//
//  FileManagerCollectionView.m
//  PhotoDeal
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import "FileManagerCollectionView.h"
#import "FileManagerCollectionViewCell.h"
#import "LocalPicModel.h"
#import "TZAssetModel.h"

@interface FileManagerCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSString *type;

@end

@implementation FileManagerCollectionView


- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    if (dataArray.count > 0) {
        id data = dataArray[0];
        
        if ([data isKindOfClass:[LocalPicModel class]]) {
            _type = @"0";
        }else{
            _type = @"1";
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    CGFloat rgb = 244 / 255.0;
    self.alwaysBounceVertical = YES;
    self.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    self.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    self.dataSource = self;
    self.delegate = self;
    
    if (!_type) {
        _type = @"0";
    }
    
    
    
    [self registerClass:[FileManagerCollectionViewCell class] forCellWithReuseIdentifier:@"FileManagerCell"];
    
    return self;
}


#pragma mark UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FileManagerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FileManagerCell" forIndexPath:indexPath];
    
    if ([self.type isEqualToString:@"0"]) {   //SDWebImage 里的缓存图片
        LocalPicModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }else{                  //图库里的音视频
        TZAssetModel *model = self.dataArray[indexPath.row];
        cell.model1 = model;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" ==> 点击了第%ld个 <==",(long)indexPath.row);
    
    BOOL isSelected = NO;
    
    if (self.type == 0) { //SDWebImage 里的缓存图片
        LocalPicModel *model = self.dataArray[indexPath.row];
        model.isSelected = !model.isSelected;
        isSelected = model.isSelected;

    }else{  //图库里的音视频
        
        TZAssetModel *model = self.dataArray[indexPath.row];
        model.isSelected    = !model.isSelected;
        isSelected = model.isSelected;
    }
    
    FileManagerCollectionViewCell *cell = (FileManagerCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.isSelected = isSelected;
}


//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
//    return YES;
//}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        CGFloat margin = 4;
        CGFloat itemWH = ([UIScreen mainScreen].bounds.size.width - 3 * margin - 4) / 4 - margin;
        return CGSizeMake(itemWH, itemWH);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
  
    return CGSizeMake(0, 0);
}






@end
