//
//  WLCategory.m
//  161129-不得姐
//
//  Created by wl on 2016/12/1.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLCategory.h"

@implementation WLCategory

- (NSMutableArray *)users
{
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    
    return _users;
}

+ (instancetype)categoryWithDict:(NSDictionary *)dict
{
    WLCategory *category = [[self alloc] init];
    [category setValuesForKeysWithDictionary:dict];
    
    return category;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.userid = value;
    }
}
@end
