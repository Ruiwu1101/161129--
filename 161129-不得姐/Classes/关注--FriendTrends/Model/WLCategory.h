//
//  WLCategory.h
//  161129-不得姐
//
//  Created by wl on 2016/12/1.
//  Copyright © 2016年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCategory : NSObject
//id
@property (nonatomic,strong) NSString *userid;
//count
@property (nonatomic,strong) NSString *count;
//name
@property (nonatomic,strong) NSString *name;
//对应分类的用户
@property (strong,nonatomic)NSMutableArray *users;
//当前页
@property (nonatomic,assign) NSInteger currentPage;
//总的用户数
@property (nonatomic,assign) NSInteger total;

+ (instancetype)categoryWithDict:(NSDictionary *)dict;
@end
