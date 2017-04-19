//
//  UIBarButtonItem+WLExtension.h
//  161129-不得姐
//
//  Created by wl on 2016/11/30.
//  Copyright © 2016年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WLExtension)
+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;
@end
