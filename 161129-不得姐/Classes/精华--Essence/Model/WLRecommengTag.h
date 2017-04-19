//
//  WLRecommengTag.h
//  161129-不得姐
//
//  Created by wl on 2016/12/5.
//  Copyright © 2016年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLRecommengTag : NSObject
@property (nonatomic,copy) NSString *theme_name;
@property (nonatomic,copy) NSString *image_list;
@property (nonatomic,copy) NSString *sub_number;

+ (instancetype)recommendTagWithDict:(NSDictionary *)dict;
@end
