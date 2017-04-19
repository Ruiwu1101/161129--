//
//  UIViewSetFrame.h
//  161129-不得姐
//
//  Created by wl on 2016/11/30.
//  Copyright © 2016年 wl. All rights reserved.
//

#ifndef UIViewSetFrame_h
#define UIViewSetFrame_h
#import "UIView+WLExtension.h"
#import "UIBarButtonItem+WLExtension.h"
#import "UIImage+WLImageExtension.h"
#import "UIImageView+WLImageViewExtenxion.h"
#ifndef DEBUG
#define WLLog(...) NSLog(__VA_ARGS__)
#else
#define WLLog(...)
#endif

#define WLRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];



#endif /* UIViewSetFrame_h */
