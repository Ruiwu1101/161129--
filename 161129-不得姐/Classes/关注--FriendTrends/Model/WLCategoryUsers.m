//
//  WLCategoryUsers.m
//  161129-不得姐
//
//  Created by wl on 2016/12/2.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLCategoryUsers.h"

@implementation WLCategoryUsers

+ (instancetype)CategoryUsersWith:(NSDictionary *)dict
{
    WLCategoryUsers *user = [[self alloc] init];
    
    user.screen_name = dict[@"screen_name"];
    user.fans_count = dict[@"fans_count"];
    user.header = dict[@"header"];
    
    return user;
}

@end
