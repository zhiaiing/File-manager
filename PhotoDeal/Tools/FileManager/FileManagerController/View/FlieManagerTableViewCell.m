//
//  FlieManagerTableViewCell.m
//  PhotoDeal
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import "FlieManagerTableViewCell.h"
#import "Masonry.h"
#import "TZImageManager.h"
#import "LocalPicModel.h"
#import "TZAssetModel.h"


@interface FlieManagerTableViewCell ()

@property (nonatomic, strong) UILabel       *NameLabel;

@property (nonatomic, strong) UIImageView   *imageview;

@property (nonatomic, strong) UILabel       *detailLabel;

@end

@implementation FlieManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self addChidView];
    
    [self setChildViewLayout];
    
    return self;
}

- (void)addChidView{
    UILabel *NameLabel      = [[UILabel alloc]init];
    NameLabel.textAlignment = NSTextAlignmentLeft;
    NameLabel.textColor     = [UIColor blackColor];
    NameLabel.font          = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:NameLabel];
    _NameLabel              = NameLabel;
    
    UIImageView *imageview          = [[UIImageView alloc]init];
    imageview.layer.masksToBounds   = YES;
    imageview.layer.cornerRadius    = 5.0;
    imageview.contentMode           = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds         = YES;
    [self.contentView addSubview:imageview];
    _imageview          = imageview;
    
    UILabel *detailLabel        = [[UILabel alloc]init];
    detailLabel.textAlignment   = NSTextAlignmentLeft;
    detailLabel.textColor       = [UIColor blackColor];
    detailLabel.font            = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:detailLabel];
    _detailLabel                = detailLabel;
    
}

- (void)setChildViewLayout{
    
    self.imageview.frame = CGRectMake(10, 10, 60, 60);
    
    self.NameLabel.frame = CGRectMake(80, 10, 375 - 90, 30);
    
    self.detailLabel.frame = CGRectMake(80, 40, 375 - 90, 30);
}

- (void)setMPMediaModel:(MPMediaItem *)MPMediaModel{
    _MPMediaModel = MPMediaModel;
    
    self.detailLabel.hidden = YES;
    
    self.imageview.image    = [UIImage imageNamed:@"music"];
    self.NameLabel.text     = MPMediaModel.title;
}

- (void)setLocalModel:(LocalPicModel *)LocalModel{
    _LocalModel = LocalModel;
    
    self.detailLabel.hidden = YES;
    
    [self.imageview setImage:[UIImage imageNamed:@"music"]];
    self.NameLabel.text     = LocalModel.fileName;
    
}

- (void)setAssetModel:(TZAssetModel *)assetModel{
    _assetModel = assetModel;
    
    [self TZAssetWithModel:assetModel];
}

- (void)TZAssetWithModel:(TZAssetModel *)assetModel{
    
    self.detailLabel.hidden = NO;
    
    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset photoWidth:self.frame.size.width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        
        self.imageview.image = photo;
    }];
    
    
    if (assetModel.names) {
        self.NameLabel.text = assetModel.names;
        self.detailLabel.text = assetModel.bytes;
    }else{
        
        //视频的操作
        [[TZImageManager manager] getVideoWithAsset:assetModel.asset completion:^(AVPlayerItem *playerItem, NSDictionary *info) {
            
            //先获取视频的路径
            NSString *path = info[@"PHImageFileSandboxExtensionTokenKey"];
            NSMutableArray * array = [NSMutableArray arrayWithArray:[path componentsSeparatedByString:@";"]];
            NSString *str = [array lastObject];
            
            //取视频名称
            NSMutableArray * array1 = [NSMutableArray arrayWithArray:[path componentsSeparatedByString:@"/"]];
            NSString *str1 = [array1 lastObject];
            
            self.assetModel.names = str1;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.NameLabel.text = str1;
            });
            
            //计算该路径下文件的大小
            [self fileSizeAtPath:str];
        }];
    }
}

- (void)fileSizeAtPath:(NSString*)filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        NSLog(@"大小   %llu",[[manager attributesOfItemAtPath:filePath error:nil] fileSize]);
        
        CGFloat a = [[manager attributesOfItemAtPath:filePath error:nil] fileSize]/1024.0/1024.0;
        
        self.assetModel.bytes = [NSString stringWithFormat:@"%.2fMB",a];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           self.detailLabel.text = [NSString stringWithFormat:@"%.2fMB",a];
        });

    }else{
        self.detailLabel.text = @"";
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
