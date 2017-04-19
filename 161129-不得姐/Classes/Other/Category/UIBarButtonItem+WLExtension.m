//
//  UIBarButtonItem+WLExtension.m
//  161129-不得姐
//
//  Created by wl on 2016/11/30.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "UIBarButtonItem+WLExtension.h"

@implementation UIBarButtonItem (WLExtension)

+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action
{
    //设置左边item
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    //监听按钮点击
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置frame
    Btn.size = Btn.currentBackgroundImage.size;
    
    return [[self alloc] initWithCustomView:Btn];
}
@end
