//
//  WLLoginBtn.m
//  161129-不得姐
//
//  Created by wl on 2016/12/6.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLLoginBtn.h"

@implementation WLLoginBtn

- (void)setUp
{
   self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setUp];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片frame
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.width;
    //设置文字frame
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.imageView.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
