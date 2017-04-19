//
//  WLTabBar.m
//  161129-不得姐
//
//  Created by wl on 2016/11/30.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLTabBar.h"
#import "WLPublishViewController.h"
@interface WLTabBar()
@property (nonatomic,weak) UIButton *publishButton;
@end
@implementation WLTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"]forState:UIControlStateHighlighted];
        
        self.publishButton = publishButton;
        [self.publishButton addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    
    return self;
}

//发布
- (void)publish
{
    WLPublishViewController *publishVC = [[WLPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置发布按钮的frame
    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    //设置其他按钮的frame
    NSInteger index = 0;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / 5;
    CGFloat buttonH = self.height;
    for (UIView *button in self.subviews) {
        if (! [button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        buttonX = index>1 ? (index + 1) * buttonW :  index * buttonW ;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //索引增加
        index++;
        
    }
}
@end
