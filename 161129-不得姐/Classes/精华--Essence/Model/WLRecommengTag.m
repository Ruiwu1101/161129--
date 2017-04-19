//
//  WLRecommengTag.m
//  161129-不得姐
//
//  Created by wl on 2016/12/5.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLRecommengTag.h"

@implementation WLRecommengTag

+ (instancetype)recommendTagWithDict:(NSDictionary *)dict
{
    WLRecommengTag *recoTag = [[self alloc] init];
    
    recoTag.theme_name = dict[@"theme_name"];
    recoTag.image_list = dict[@"image_list"];
    recoTag.sub_number = dict[@"sub_number"];
    
    return recoTag;
}
@end
