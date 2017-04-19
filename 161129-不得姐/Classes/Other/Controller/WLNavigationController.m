//
//  WLNavigationController.m
//  161129-不得姐
//
//  Created by wl on 2016/11/30.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLNavigationController.h"
#import "WLEssenceController.h"
@interface WLNavigationController ()

@end

@implementation WLNavigationController

//第一次使用这个类的时候会调用
+(void)initialize
{
    NSArray *Container = @[[self class]];
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:Container];
    
        [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        btn.size = CGSizeMake(70, 40);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
       
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)pop
{
    [self popViewControllerAnimated:YES];
}

@end
