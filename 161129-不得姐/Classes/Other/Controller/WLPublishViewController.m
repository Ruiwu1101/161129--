

//
//  WLPublishViewController.m
//  161129-不得姐
//
//  Created by wl on 2016/12/14.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLPublishViewController.h"
#import "WLPublishBtn.h"
#import <POP.h>
#define WLScreen [UIScreen mainScreen].bounds.size
@interface WLPublishViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sloganView;


@end

@implementation WLPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置子控件的frame
    [self setUpChildViewFrame];
}

//设置子控件的frame
- (void)setUpChildViewFrame
{
    CGPoint center = CGPointZero;
    center.x = WLScreen.width * 0.5;
    self.sloganView.center = center;
    self.sloganView.y = WLScreen.height * 0.2;
    //按钮的内容数据
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"发链接"];
    NSArray *imanges = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-link"];
    NSInteger count = titles.count;
    CGFloat btnH = 100;
    CGFloat btnW = 75;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    NSInteger column = 3;
    CGFloat margin = (WLScreen.width - 3 * btnW) / 4;
    for (NSInteger i = 0; i<count; i++) {
        WLPublishBtn *btn = [[WLPublishBtn alloc] init];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imanges[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
        btnX = (i % column) * (btnW + margin) + margin;
        btnY = WLScreen.height * 0.3 + (i / column) * (btnH + margin);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [self.bgImageView addSubview:btn];
        
    }
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
