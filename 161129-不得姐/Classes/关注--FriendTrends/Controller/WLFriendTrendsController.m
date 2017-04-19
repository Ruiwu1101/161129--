//
//  WLFriendTrendsController.m
//  161129-不得姐
//
//  Created by wl on 2016/11/30.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLFriendTrendsController.h"
#import "WLConcernViewController.h"
#import "WLLoginViewController.h"
@interface WLFriendTrendsController ()

@end

@implementation WLFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setUpNavBar];
    
    //设置背景色
    self.view.backgroundColor = WLRGBColor(223, 223, 223);
}

- (IBAction)login:(id)sender {
    
    WLLoginViewController *loginVC = [[WLLoginViewController alloc] init];
    
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
}

- (IBAction)register:(id)sender {
}

- (void)setUpNavBar
{
    //设置标题
    self.navigationItem.title = @"我的关注";
    
    //设置左边item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsBtnClick)];
}

- (void)friendsBtnClick
{
    WLConcernViewController *conVC = [[WLConcernViewController alloc] init];
    [self.navigationController pushViewController:conVC animated:YES];
}

@end
