//
//  WLCategoryUsers.h
//  161129-不得姐
//
//  Created by wl on 2016/12/2.
//  Copyright © 2016年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCategoryUsers : NSObject
@property (strong,nonatomic)NSString *fans_count;
@property (strong,nonatomic)NSString *header;
@property (strong,nonatomic)NSString *screen_name;

+ (instancetype)CategoryUsersWith:(NSDictionary *)dict;
@end
