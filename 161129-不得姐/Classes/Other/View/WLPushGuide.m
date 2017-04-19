//
//  WLPushGuide.m
//  161129-不得姐
//
//  Created by wl on 2016/12/7.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLPushGuide.h"

@implementation WLPushGuide

+(void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    WLPushGuide *pushView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    //获取当前版本号
    NSString *key = @"CFBundleShortVersionString";
    //当前版本号
    NSString *currenVersion = [NSBundle mainBundle].infoDictionary[key];
    //沙盒中的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currenVersion isEqualToString:sanboxVersion]) {//不同的版本号
        //显示引导页
        [window addSubview:pushView];
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currenVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}
- (IBAction)closePushCuide:(id)sender {
    
    [self removeFromSuperview];
}

@end
