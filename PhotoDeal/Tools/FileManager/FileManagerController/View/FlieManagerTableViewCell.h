//
//  FlieManagerTableViewCell.h
//  PhotoDeal
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMediaItem.h>

@class TZAssetModel, LocalPicModel;
@interface FlieManagerTableViewCell : UITableViewCell

@property (nonatomic, strong) TZAssetModel  *assetModel;

@property (nonatomic, strong) MPMediaItem   *MPMediaModel;

@property (nonatomic, strong) LocalPicModel *LocalModel;

@end
