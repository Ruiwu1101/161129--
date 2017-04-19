//
//  WLTabBarController.m
//  161129-不得姐
//
//  Created by wl on 2016/11/29.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLTabBarController.h"
#import "WLEssenceController.h"
#import "WLNewController.h"
#import "WLFriendTrendsController.h"
#import "WLMeController.h"
#import "WLNavigationController.h"
#import "WLTabBar.h"
@interface WLTabBarController ()

@end

@implementation WLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置子控制器
    [self setUpChildVCWith:[[WLEssenceController alloc] init] title:@"精华" selectedImage:@"tabBar_essence_click_icon" normolImage:@"tabBar_essence_icon"];
    [self setUpChildVCWith:[[WLNewController alloc] init] title:@"最新" selectedImage:@"tabBar_new_click_icon" normolImage:@"tabBar_new_icon"];
    [self setUpChildVCWith:[[WLFriendTrendsController alloc] init] title:@"关注" selectedImage:@"tabBar_friendTrends_click_icon" normolImage:@"tabBar_friendTrends_icon"];
    [self setUpChildVCWith:[[WLMeController alloc] init] title:@"我" selectedImage:@"tabBar_me_click_icon" normolImage:@"tabBar_me_icon"];
    
    //添加自定义的TabBar
    [self setValue:[[WLTabBar alloc] init] forKeyPath:@"tabBar"];
}

//创建子控制器
- (void)setUpChildVCWith:(UIViewController *)VC title:(NSString *)title selectedImage:(NSString *)selectedImage normolImage :(NSString *)normalImage
{
    
    UITabBarItem *item = VC.tabBarItem;
    //设置标题
    VC.tabBarItem.title = title;
    
    NSMutableDictionary *attributs = [NSMutableDictionary dictionary];
    attributs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selecattributs = [NSMutableDictionary dictionary];
    selecattributs[NSForegroundColorAttributeName] = [UIColor colorWithRed:251/255.0 green:12/255.0 blue:68/255.0 alpha:10];
    
    [item setTitleTextAttributes:attributs forState:UIControlStateNormal];
    
    [item setTitleTextAttributes:selecattributs forState:UIControlStateSelected];
    
    //设置普通状态的图片
    item.image = [UIImage imageNamed:normalImage];
    
    //设置选中的图片
    UIImage *image = [UIImage imageNamed:selectedImage];
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.selectedImage = image;
    
    //添加子控制器
    WLNavigationController *nav = [[WLNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
    
}

@end
