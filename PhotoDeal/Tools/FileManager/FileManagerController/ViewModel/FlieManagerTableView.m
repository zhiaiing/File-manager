//
//  FlieManagerTableView.m
//  PhotoDeal
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import "FlieManagerTableView.h"
#import "FlieManagerTableViewCell.h"
#import "TZAssetModel.h"
#import <MediaPlayer/MPMediaItem.h>
#import "LocalPicModel.h"

@interface FlieManagerTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *type;

@end

@implementation FlieManagerTableView

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    if (dataArray.count > 0) {
        id data = dataArray[0];
        
        if ([data isKindOfClass:[TZAssetModel class]]) {
            _type = @"0";
        }else if([data isKindOfClass:[MPMediaItem class]]){
            _type = @"1";
        }else{
            _type = @"2";   
        }
    }
    
    [self reloadData];
}

- (instancetype)init{
    
    self = [super init];
    
    if (!_type) {
        _type = @"0";
    }
    
    self.delegate   = self;
    self.dataSource = self;
    
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuserid = @"flieManagerTableViewCell";
    
    FlieManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserid];
    
    if (cell == nil) {
        cell = [[FlieManagerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserid];
    }
    
    if ([self.type isEqualToString:@"0"]) {
        TZAssetModel *model = self.dataArray[indexPath.row];
        cell.assetModel     = model;
    }else if([self.type isEqualToString:@"1"]){
        MPMediaItem *model      = self.dataArray[indexPath.row];
        cell.MPMediaModel       = model;
    }else{
        LocalPicModel *model    = self.dataArray[indexPath.row];
        cell.LocalModel         = model;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




@end
