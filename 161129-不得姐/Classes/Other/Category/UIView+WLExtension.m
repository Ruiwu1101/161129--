//
//  UIView+WLExtension.m
//  161129-不得姐
//
//  Created by wl on 2016/11/30.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "UIView+WLExtension.h"

@implementation UIView (WLExtension)

- (void)setSize:(CGSize)size
{
    CGRect Myframe = self.frame;
    Myframe.size = size;
    
    self.frame = Myframe;
}

- (void)setWidth:(CGFloat)width
{
    CGRect Myframe = self.frame;
    Myframe.size.width = width;
    
    self.frame = Myframe;
}

- (void)setHeight:(CGFloat)height
{
    CGRect Myframe = self.frame;
    
    Myframe.size.height = height;
    
    self.frame = Myframe;
}

- (void)setX:(CGFloat)x
{
    CGRect Myframe = self.frame;
    Myframe.origin.x = x;
    
    self.frame = Myframe;
}

- (void)setY:(CGFloat)y
{
   CGRect Myframe = self.frame;
    
    Myframe.origin.y = y;
    
    self.frame = Myframe;
    
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}
@end
