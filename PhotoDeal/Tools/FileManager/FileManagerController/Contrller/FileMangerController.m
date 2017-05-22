//
//  FileMangerController.m
//  PhotoDeal
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import "FileMangerController.h"
#import "HYPageView.h"

#import "FileMangerVideoViewController.h"
#import "FlieMangerPicViewController.h"
#import "FileManger.h"

@interface FileMangerController ()

@property (nonatomic, weak  ) UISegmentedControl                    *segmentedControl;

@property (nonatomic, weak  ) UIScrollView                          *baseScroller;

@property (nonatomic, weak  ) HYPageView                            *pageView1;

@property (nonatomic, weak  ) HYPageView                            *pageView2;

@end

@implementation FileMangerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addBaseScroller];
    
    [self setNavTitleView];
    
    [self setLocalControllers];
    
    [self setAppSanBoxController];
    
}

- (void)addBaseScroller{
    UIScrollView *scroller      = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    scroller.scrollEnabled = NO;
    // scroller.pagingEnabled      = YES;
    scroller.contentSize        = CGSizeMake(self.view.frame.size.width *2,0);
    [self.view addSubview:scroller];
    _baseScroller               = scroller;
}

- (void)setNavTitleView{
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"最近",@"本机",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.frame = CGRectMake(0, 0, 160, 28);
    /*
     这个是设置按下按钮时的颜色
     */
    segmentedControl.tintColor = [UIColor whiteColor];
    segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引
    
    /*
     下面的代码实同正常状态和按下状态的属性控制,比如字体的大小和颜色等
     */
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil, nil];
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor colorWithHexString:@"#3e6c9e"] forKey:NSForegroundColorAttributeName];
    
    [segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    //设置分段控件点击相应事件
    [segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    
    _segmentedControl = segmentedControl;
    
    self.navigationItem.titleView = segmentedControl;
}

- (void)doSomethingInSegment:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index){
        case 0:{
            [UIView animateWithDuration:0.5 animations:^{
                self.baseScroller.contentOffset = CGPointMake(0, 0);
            }];
        }
            break;
            
        case 1:{
            [UIView animateWithDuration:0.5 animations:^{
                self.baseScroller.contentOffset = CGPointMake(self.view.frame.size.width, 0);
            }];
        }
            break;
            
        default:
            break;
    }
}


- (void)setLocalControllers{ //iphone里的
    
    NSMutableArray *titleArray = [NSMutableArray array];
    [titleArray addObject:@"文档"];
    [titleArray addObject:@"视频"];
    [titleArray addObject:@"相册"];
    [titleArray addObject:@"音乐"];
    [titleArray addObject:@"其他"];
    
    
    // 0 本机(iphone)视频   1 沙盒里的视频 默认为0  2 本机(iphone)音乐  3 沙盒的音乐 4 沙盒的word 5 沙盒的其他 6 本机(iphone)的文档 7 本机(iphone)的其他
    
    FileMangerVideoViewController *Video0 = [[FileMangerVideoViewController alloc]init];
    Video0.picType = @"6";
    
    FileMangerVideoViewController *Video1 = [[FileMangerVideoViewController alloc]init];
    Video1.picType = @"0";
    
    FlieMangerPicViewController *pic = [[FlieMangerPicViewController alloc]init];
    pic.picType = @"0";
    
    FileMangerVideoViewController *Video2 = [[FileMangerVideoViewController alloc]init];
    Video2.picType = @"2";
    
    
    FileMangerVideoViewController *Video3 = [[FileMangerVideoViewController alloc]init];
    Video3.picType = @"7";
  
    
    NSMutableArray *ChildController = [NSMutableArray array];
    [ChildController addObject:Video0];
    [ChildController addObject:Video1];
    [ChildController addObject:pic];
    [ChildController addObject:Video2];
    [ChildController addObject:Video3];
    
    HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight) withTitles:titleArray withViewControllers:ChildController withParameters:nil];
    
    pageView.selectedColor = [UIColor redColor];
    pageView.unselectedColor = [UIColor blackColor];
    [self.baseScroller addSubview:pageView];
    _pageView1 = pageView;
}

- (void)setAppSanBoxController{ //SandBox
    NSMutableArray *titleArray = [NSMutableArray array];
    [titleArray addObject:@"文档"];
    [titleArray addObject:@"视频"];
    [titleArray addObject:@"相册"];
    [titleArray addObject:@"音乐"];
    [titleArray addObject:@"其他"];
    
    // 0 本机(iphone)视频   1 沙盒里的视频 默认为0  2 本机(iphone)音乐  3 沙盒的音乐 4 沙盒的word 5 沙盒的其他 6 本机(iphone)的文档 7 本机(iphone)的其他
    
    FileMangerVideoViewController *Video0 = [[FileMangerVideoViewController alloc]init];
    Video0.picType = @"4";
    
    FileMangerVideoViewController *Video1 = [[FileMangerVideoViewController alloc]init];
    Video1.picType = @"1";
    
    FlieMangerPicViewController *pic = [[FlieMangerPicViewController alloc]init];
    pic.picType = @"1";
    
    FileMangerVideoViewController *Video2 = [[FileMangerVideoViewController alloc]init];
    Video2.picType = @"3";
    
    FileMangerVideoViewController *Video3 = [[FileMangerVideoViewController alloc]init];
    Video3.picType = @"5";
    
    
    NSMutableArray *ChildController = [NSMutableArray array];
    [ChildController addObject:Video0];
    [ChildController addObject:Video1];
    [ChildController addObject:pic];
    [ChildController addObject:Video2];
    [ChildController addObject:Video3];
    
    HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(KWidth, 0, KWidth, KHeight) withTitles:titleArray withViewControllers:ChildController withParameters:nil];
    
    pageView.selectedColor = [UIColor redColor];
    pageView.unselectedColor = [UIColor blackColor];
    [self.baseScroller addSubview:pageView];
    _pageView2 = pageView;
}

- (void)aasder{
    
    NSArray *array = [[FileManger shareInit] getSdWebImageArr];
    
    
//    
//    int entryLength = (NSInteger)FICByteAlign(_imageLength + sizeof(FICImageTableEntryMetadata), [FICImageTable pageSize]);
//    
//    // Each chunk will map in n entries. Try to keep the chunkLength around 2MB.
//    NSInteger goalChunkLength = 2 * (1024 * 1024);
//    NSInteger goalEntriesPerChunk = goalChunkLength / _entryLength;
//    _entriesPerChunk = MAX(4, goalEntriesPerChunk);
//    
//    
//    if ([self _maximumCount] > [_imageFormat maximumCount]) {
//        NSString *message = [NSString stringWithFormat:@"*** FIC Warning: growing desired maximumCount (%ld) for format %@ to fill a chunk (%ld)", (long)[_imageFormat maximumCount], [_imageFormat name], (long)[self _maximumCount]];
//        [self.imageCache _logMessage:message];
//    }
//    _chunkLength = (size_t)(_entryLength * _entriesPerChunk);
//    
//    _fileLength = lseek(_fileDescriptor, 0, SEEK_END);
//    _entryCount = (NSInteger)(_fileLength / _entryLength);
//    _chunkCount = (_entryCount + _entriesPerChunk - 1) / _entriesPerChunk;

    
    
  
    
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    int  fileDescriptor = open([[paths[0] stringByAppendingPathComponent:@"aaa"] fileSystemRepresentation], O_RDWR | O_CREAT, 0666);
    
    if (fileDescriptor >= 0) {
        NSLog(@"创建并设置文件权限成功 或 权限对应");
    }else{
        NSLog(@"权限不对应");
    }
}

//取得内存分页大小
+ (int)pageSize {
    static int __pageSize = 0;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __pageSize = getpagesize();
    });
    
    return __pageSize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
