//
//  FileManagerTableView.m
//  PhotoDeal
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import "FileManagerTableView.h"
#import "LocalPicModel.h"
#import "UIImageView+WebCache.h"

@interface FileManagerTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation FileManagerTableView

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    [self reloadData];
}

- (instancetype)init{
    
    self = [super init];
    
    self.delegate   = self;
    self.dataSource = self;
    
    _dataArray = [NSMutableArray array];
    
    return self;

}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LocalPicModel *model = self.dataArray[indexPath.row];
    
    NSString *resuerid = @"reuserFileMangerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuerid];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuerid];
    }

    if ([model.fileType isEqualToString:@"pic"]) {
        [cell.imageView setImage:[UIImage imageWithContentsOfFile:model.filePath]];
        cell.textLabel.text = model.fileName;
    }
    
    return cell;
}

@end
