//
//  WLPublishBtn.m
//  161129-不得姐
//
//  Created by wl on 2016/12/14.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLPublishBtn.h"

@implementation WLPublishBtn
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
    self.imageView.frame = CGRectMake(0, 0, self.width, self.width);
    
    self.titleLabel.frame = CGRectMake(0, self.width + 10, self.width, self.height - self.width - 10);
}

@end
