//
//  FileManger.m
//  PhotoDeal
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import "FileManger.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "TZImageManager.h"
#import "TZAssetModel.h"
#import <objc/message.h>
#import "SDWebImageManager.h"
#import "LocalPicModel.h"

//#import <MediaPlayer/MediaPlayerDefines.h>
#import <MediaPlayer/MPMediaItem.h>
#import <MediaPlayer/MediaPlayer.h>

#import <MediaPlayer/MPContentItem.h>


#import <MediaPlayer/MPMediaItemCollection.h>


static FileManger *filrMarager;

@interface FileManger ()

@property (nonatomic, strong) NSFileManager *Manager;

@end

@implementation FileManger

+ (instancetype)shareInit{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        filrMarager = [[self alloc] init];
    });

    return filrMarager;
}

- (instancetype)init{
    self = [super init];
    
    _Manager = [NSFileManager defaultManager];

   // [self readDocumentFileList];

    return self;
}

//直接取图库数据 不用TZImageManager
/*
- (void)getThumbnailImages{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [self enumerateAssetsInAssetCollection:assetCollection original:NO];
    }
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [self enumerateAssetsInAssetCollection:cameraRoll original:NO];
}
 

//  遍历相簿中的所有图片
//  @param assetCollection 相簿
//  @param original        是否要原图
//
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original{
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"%@", result);
            NSLog(@"info ==========> %@",info);
        }];
    }
}
*/


//读取本机图片
- (NSArray *)readLocalMachinePic{
    
    __block NSArray *array = [NSArray array];
    
    NSArray *att = [self readLocalMachineFileWithIsVideo:NO];
    //return
    
    TZAlbumModel *model = att[0];
    
    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
        array = models;
    }];
    
    return array;
}

//读取本机视频
- (NSArray *)readLocalMachineVideo{
    __block NSArray *array = [NSArray array];
    
    NSArray *att = [self readLocalMachineFileWithIsVideo:YES];
    
    TZAlbumModel *model = att[0];
    
    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:YES allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
        array = models;
    }];
    
    return array;
}


- (NSArray *)readLocalMachineMusic{
    
    MPMediaQuery *allMp3 = [[MPMediaQuery alloc] init];
    // 读取条件
    MPMediaPropertyPredicate *albumNamePredicate =
    [MPMediaPropertyPredicate predicateWithValue:[NSNumber numberWithInt:MPMediaTypeMusic ] forProperty: MPMediaItemPropertyMediaType];
    [allMp3 addFilterPredicate:albumNamePredicate];
    
    NSArray *arr = [allMp3 items];
    
//    for (MPMediaItem *song in arr) {
//        //没有url 是因为 版权问题
//        NSString *songTitle = song.title;
//        NSLog (@"song ==============> %@, %lu, %@, %@", songTitle, (unsigned long)song.mediaType, song.assetURL,song.artist);
//    }
    
    return arr;
}


//获取SDWebImage 里缓存的图片信息
- (NSArray *)getSdWebImageArr{
    return [self getAllMarager];
}


//获取沙盒里的视频
- (NSArray *)readSandBoxVideo{
    return [self readDocumentFileListWithType:0];
}


//获取沙盒里的音乐
- (NSArray *)readSandBoxMusic{
    return [self readDocumentFileListWithType:1];
}

//获取沙盒里的Word文件
- (NSArray *)readSandBoxWord{
    return [self readDocumentFileListWithType:2];
}

//获取沙盒里的Other文件
- (NSArray *)readSandBoxOtherFile{
    return [self readDocumentFileListWithType:3];
}


//最好每次都要重新调用这个方法 返回 SDWebImage 里缓存的图片信息
- (NSArray *)getAllMarager{
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *string = [self makeDiskCachePath:@"default"];
    
    NSString *diskCachePath = [NSString stringWithFormat:@"%@/com.hackemist.SDWebImageCache.default",string];
    
    NSArray *tempFileList = [[NSArray alloc] initWithArray:[self.Manager contentsOfDirectoryAtPath:diskCachePath error:nil]];
    
    for (NSString *str in tempFileList) {
        LocalPicModel *model = [[LocalPicModel alloc]init];
        model.fileName   = str;
        model.filePath   = [NSString stringWithFormat:@"%@/%@",diskCachePath,str];
        model.fileType  = @"pic";
        
        [array addObject:model];
    }
    return array;
}

- (nullable NSString *)makeDiskCachePath:(nonnull NSString*)fullNamespace {
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    
    return [paths[0] stringByAppendingPathComponent:fullNamespace];
}

//读取本机的媒体库(照片 视频)
- (NSArray *)readLocalMachineFileWithIsVideo:(BOOL)isVideo{
    
     __block NSMutableArray *array = [NSMutableArray array];
    
    [[TZImageManager manager] getAllAlbums:YES allowPickingImage:YES completion:^(NSArray<TZAlbumModel *> *models) {
        
        if (isVideo) {
            for (TZAlbumModel *model in models) {
                if ([model.name isEqualToString:@"Videos"]) {
                    [array addObject:model];
                }
                NSLog(@"%@",model.name);
            }
        }else{
            for (TZAlbumModel *model in models) {
                if([model.name isEqualToString:@"Camera Roll"] || [model.name isEqualToString:@"相机胶卷"] || [model.name isEqualToString:@"所有照片"] || [model.name isEqualToString:@"All Photos"]){
                    [array addObject:model];
                }
            }
        }
    }];
    
    return array;
}





//0视频 1音频 2word 3其他
- (NSArray *)readDocumentFileListWithType:(NSInteger )type{
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSArray *DocumentFileList = [[NSArray alloc] initWithArray:[self.Manager contentsOfDirectoryAtPath:docPath error:nil]];
    
    NSLog(@"DocumentFileList ==> %@",DocumentFileList);
    
    NSMutableArray *array = [NSMutableArray array];
    
    for(NSString *Path in DocumentFileList){
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",docPath,Path];
        
        //获得文件的后缀名 （不带'.'）
        NSString *suffix = [filePath pathExtension];
        
        //从路径中获得完整的文件名 （带后缀）
        NSString *fileName = [filePath lastPathComponent];
        
        LocalPicModel *model = [[LocalPicModel alloc]init];
        model.fileName   = fileName;
        model.filePath   = [NSString stringWithFormat:@"%@/%@",docPath,fileName];
        model.fileType   = suffix;

        if (type == 0) {
            if ([suffix caseInsensitiveCompare:@"MP4"]  == NSOrderedSame    ||
                [suffix caseInsensitiveCompare:@"AVI"]  == NSOrderedSame    ||
                [suffix caseInsensitiveCompare:@"RMVB"] == NSOrderedSame    ||
                [suffix caseInsensitiveCompare:@"WMV"]  == NSOrderedSame    ||
                [suffix caseInsensitiveCompare:@"ASF"]  == NSOrderedSame    ||
                [suffix caseInsensitiveCompare:@"MPG"]  == NSOrderedSame    ||
                [suffix caseInsensitiveCompare:@"DVD"]  == NSOrderedSame) {//视频文件
                [array addObject:model];
            }
        }else if (type == 1) {
            if ([suffix caseInsensitiveCompare:@"MP4"]  == NSOrderedSame    ||
                [suffix caseInsensitiveCompare:@"AVI"]  == NSOrderedSame    ||
                [suffix caseInsensitiveCompare:@"mp3"]  == NSOrderedSame) {//音频文件
                [array addObject:model];
            }
        }else if(type == 2){
            if ([suffix caseInsensitiveCompare:@"doc"]  == NSOrderedSame    ||
                [suffix caseInsensitiveCompare:@"xls"]  == NSOrderedSame    ||
                [suffix caseInsensitiveCompare:@"docx"] == NSOrderedSame    ||
                [suffix caseInsensitiveCompare:@"xlsx"] == NSOrderedSame){//音频文件
                [array addObject:model];
            }
        }else{
            if ([suffix caseInsensitiveCompare:@"MP4"]  != NSOrderedSame    &&
                [suffix caseInsensitiveCompare:@"AVI"]  != NSOrderedSame    &&
                [suffix caseInsensitiveCompare:@"RMVB"] != NSOrderedSame    &&
                [suffix caseInsensitiveCompare:@"WMV"]  != NSOrderedSame    &&
                [suffix caseInsensitiveCompare:@"ASF"]  != NSOrderedSame    &&
                [suffix caseInsensitiveCompare:@"MPG"]  != NSOrderedSame    &&
                [suffix caseInsensitiveCompare:@"DVD"]  != NSOrderedSame    &&
                [suffix caseInsensitiveCompare:@"MP4"]  != NSOrderedSame    &&
                [suffix caseInsensitiveCompare:@"AVI"]  != NSOrderedSame    &&
                [suffix caseInsensitiveCompare:@"mp3"]  != NSOrderedSame    &&
                [suffix caseInsensitiveCompare:@"doc"]  != NSOrderedSame    &&
                [suffix caseInsensitiveCompare:@"xls"]  != NSOrderedSame    &&
                [suffix caseInsensitiveCompare:@"docx"] != NSOrderedSame    &&
                [suffix caseInsensitiveCompare:@"xlsx"] != NSOrderedSame){//其他文件
                [array addObject:model];
            }
        }
        
        NSLog(@"%@  %@",suffix,fileName);
    }
    
    return array;
}

+ (NSArray *) getAllFileNames:(NSString *)dirName{
    // 获得此程序的沙盒路径
    NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // 获取Documents路径
    // [patchs objectAtIndex:0]
    NSString *documentsDirectory = [patchs objectAtIndex:0];
    NSString *fileDirectory = [documentsDirectory stringByAppendingPathComponent:dirName];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:fileDirectory error:nil];
    return files;
}







@end
