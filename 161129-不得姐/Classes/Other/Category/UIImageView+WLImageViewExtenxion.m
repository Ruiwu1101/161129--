//
//  UIImageView+WLImageViewExtenxion.m
//  161129-不得姐
//
//  Created by wl on 2016/12/18.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "UIImageView+WLImageViewExtenxion.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (WLImageViewExtenxion)
- (void)setIconView:(NSString *)url
{
    NSURL *imageUrl = [NSURL URLWithString:url];
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:imageUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : [placeholder circleImage];
    }];
}
@end
