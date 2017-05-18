//
//  PopView.m
//  PhotoDeal
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 lanxiao. All rights reserved.
//

#import "PopView.h"
#import "Masonry.h"
#import "SDAutoLayout.h"
#import "POP.h"

static CGFloat length = 100;

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#define BtnWH  40



@interface PopView ()

@property (nonatomic, strong) UIButton  *moreBtn;

@property (nonatomic, strong) UIButton  *PicBtn;

@property (nonatomic, strong) UIButton  *CamBtn;

@property (nonatomic, strong) UIButton  *GifBtn;

@property (nonatomic, assign) CGRect    PicBtnRect;

@property (nonatomic, assign) CGRect    CamBtnRect;

@property (nonatomic, assign) CGRect    GifBtnRect;

@property (nonatomic, assign) CGRect    changedRect;

@property (nonatomic, assign) CGRect    minFrame;

@property (nonatomic, assign) CGRect    maxFrame;



@end

@implementation PopView

- (instancetype)initWithFrame:(CGRect)frame andMaxframe:(CGRect )maxFrame{
    
    self = [super initWithFrame:frame];
    
    _minFrame = frame;
    
    _maxFrame = maxFrame;
    
    [self setRectWithMaxFrame:maxFrame];
    
    [self loadView];

    return self;
}


- (void)setRectWithMaxFrame:(CGRect )maxFrame{
    self.PicBtnRect = CGRectMake(maxFrame.size.width - BtnWH - length, maxFrame.size.height - BtnWH, BtnWH, BtnWH);
    
    CGFloat XX = length*sin(DEGREES_TO_RADIANS(45));
    CGFloat YY = length*cos(DEGREES_TO_RADIANS(45));
    
    self.CamBtnRect = CGRectMake(maxFrame.size.width - XX - BtnWH, maxFrame.size.height - YY - BtnWH, BtnWH, BtnWH);
    
    self.GifBtnRect = CGRectMake(maxFrame.size.width - BtnWH, maxFrame.size.height - length - BtnWH, BtnWH, BtnWH);
    
    self.changedRect = CGRectMake(maxFrame.size.width - BtnWH, maxFrame.size.height - BtnWH, BtnWH, BtnWH);
}


- (void)loadView{
    
    self.PicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.PicBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.PicBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.PicBtn addTarget:self action:@selector(PicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.PicBtn];
    
    self.CamBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.CamBtn setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
    [self.CamBtn addTarget:self action:@selector(CamBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.CamBtn];
    
    self.GifBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.GifBtn setImage:[UIImage imageNamed:@"settings_icon"] forState:UIControlStateNormal];
    [self.GifBtn addTarget:self action:@selector(GifBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.GifBtn];
    
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.moreBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.moreBtn];
    
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.width.mas_equalTo(BtnWH);
        make.height.mas_equalTo(BtnWH);
    }];
    
    self.PicBtn.frame = self.changedRect;
    
    self.CamBtn.frame = self.changedRect;
    
    self.GifBtn.frame = self.changedRect;
    
}

- (void)moreBtnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;

    if (_clickBtnBlock){
        _clickBtnBlock(btn,0);
    }
}

- (void)PicBtnClick:(UIButton *)btn{
    self.moreBtn.selected = NO;
   
    if (_clickBtnBlock){
        _clickBtnBlock(btn,1);
    }
    
}

- (void)CamBtnClick:(UIButton *)btn{
    self.moreBtn.selected = NO;
    if (_clickBtnBlock){
        _clickBtnBlock(btn,2);
    }
}

- (void)GifBtnClick:(UIButton *)btn{
    self.moreBtn.selected = NO;
    if (_clickBtnBlock){
        _clickBtnBlock(btn,3);
    }
}



- (void)startAnimation{
    
    self.frame = self.maxFrame;

    [UIView animateWithDuration:0.5 animations:^{
        
        self.PicBtn.frame = self.PicBtnRect;
        
        self.CamBtn.frame = self.CamBtnRect;
        
        self.GifBtn.frame = self.GifBtnRect;

    }];
}

- (void)endAnimation{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.PicBtn.frame = self.changedRect;
        
        self.CamBtn.frame = self.changedRect;
        
        self.GifBtn.frame = self.changedRect;
        
    } completion:^(BOOL finished) {
        if (finished) {
            self.frame = self.minFrame;
        }
    }];
    
}























@end
