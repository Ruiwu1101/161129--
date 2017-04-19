//
//  WLProgressView.m
//  161129-不得姐
//
//  Created by wl on 2016/12/12.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLProgressView.h"

@implementation WLProgressView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    NSString *test = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    test = [test stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.progressLabel.text = test;
    
}
@end
