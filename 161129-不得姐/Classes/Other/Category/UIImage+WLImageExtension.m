//
//  UIImage+WLImageExtension.m
//  161129-不得姐
//
//  Created by wl on 2016/12/18.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "UIImage+WLImageExtension.h"

@implementation UIImage (WLImageExtension)
- (UIImage *)circleImage
{
  //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
  //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
  //添加一个○
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
  //裁剪
    CGContextClip(ctx);
  //将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  //结束图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}
@end
