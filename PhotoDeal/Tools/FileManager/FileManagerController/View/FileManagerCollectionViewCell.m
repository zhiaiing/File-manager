//
//  FileManagerCollectionViewCell.m
//  PhotoDeal
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import "FileManagerCollectionViewCell.h"
#import "LocalPicModel.h"
#import "UIImageView+WebCache.h"
#import "TZAssetModel.h"
#import "TZImageManager.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface FileManagerCollectionViewCell ()

//图片的
@property (nonatomic, strong) UIImageView *imageView1;


@property (nonatomic, strong) UIImageView *videoImageView;

//蒙版选中的图片
@property (nonatomic, strong) UIImageView *MaskImageView;

@end

@implementation FileManagerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds      = YES;
        
        self.backgroundColor    = [UIColor whiteColor];
        _imageView1             = [[UIImageView alloc] initWithFrame:frame];
        _imageView1.hidden      = NO;
        _imageView1.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView1];
        
        
        _videoImageView             = [[UIImageView alloc] init];
        _videoImageView.image       = [UIImage imageNamed:@"video"];
        _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _videoImageView.hidden      = YES;
        [self addSubview:_videoImageView];
        
        
        _MaskImageView                  = [[UIImageView alloc] init];
        _MaskImageView.backgroundColor  = [UIColor colorWithWhite:1.000 alpha:0.3];
        _MaskImageView.contentMode      = UIViewContentModeScaleAspectFit;
        _MaskImageView.image            = [UIImage imageNamed:@"selected"];
        _MaskImageView.hidden           = YES;
        [self addSubview:_MaskImageView];
        
    }
    return self;
}

- (void)setModel:(LocalPicModel *)model{
    _model = model;
    
    if ([model.fileType isEqualToString:@"pic"]) {
        
        self.imageView1.image = [UIImage imageWithContentsOfFile:model.filePath];
        self.videoImageView.hidden = YES;

    }else{
        self.imageView1.hidden = YES;
        self.videoImageView.hidden = NO;
    }
    
    if (model.isSelected) {
        self.MaskImageView.hidden = NO;
    }else{
        self.MaskImageView.hidden = YES;
    }
}

- (void)setModel1:(TZAssetModel *)model1{
    _model1 = model1;
    
    [[TZImageManager manager] getPhotoWithAsset:model1.asset photoWidth:self.frame.size.width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        
        self.imageView1.image = photo;
        
    }];
    
//    if(model1.type == TZAssetModelMediaTypeVideo){
//        //视频的操作
//        [[TZImageManager manager] getVideoWithAsset:model1.asset completion:^(AVPlayerItem *playerItem, NSDictionary *info) {
//            
//            //先获取视频的路径
//            NSString *path = info[@"PHImageFileSandboxExtensionTokenKey"];
//            NSMutableArray * array = [NSMutableArray arrayWithArray:[path componentsSeparatedByString:@";"]];
//            NSString *str = [array lastObject];
//            //计算该路径下文件的大小
//            [self fileSizeAtPath:str];
//            
//        }];
//    }else if(model1.type == TZAssetModelMediaTypePhoto || model1.type == TZAssetModelMediaTypeLivePhoto || model1.type == TZAssetModelMediaTypePhotoGif){ //照片
//
//    }
    
    if (model1.isSelected) {
        self.MaskImageView.hidden = NO;
    }else{
        self.MaskImageView.hidden = YES;
    }
}

- (long long) fileSizeAtPath:(NSString*)filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        NSLog(@"大小   %llu",[[manager attributesOfItemAtPath:filePath error:nil] fileSize]);

        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView1.frame = self.bounds;
    
    self.videoImageView.frame = self.bounds;
    
    self.MaskImageView.frame = self.bounds;
}

- (void)setIsSelected:(BOOL)isSelected{
    
    _isSelected = isSelected;
    
    if (self.model) {
        self.model.isSelected  = isSelected;
    }else{
        self.model1.isSelected = isSelected;
    }
    
    if (isSelected) {
        self.MaskImageView.hidden = NO;
    }else{
        self.MaskImageView.hidden = YES;
    }
    
}




@end








@implementation UIImage (MyBundle)

+ (UIImage *)imageNamedFromMyBundle:(NSString *)name {
    UIImage *image = [UIImage imageNamed:[@"TZImagePickerController.bundle" stringByAppendingPathComponent:name]];
    if (image) {
        return image;
    } else {
        image = [UIImage imageNamed:[@"Frameworks/TZImagePickerController.framework/TZImagePickerController.bundle" stringByAppendingPathComponent:name]];
        if (!image) {
            image = [UIImage imageNamed:name];
        }
        return image;
    }
}
@end


