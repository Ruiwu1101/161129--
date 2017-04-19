//
//  WLEssenceController.m
//  161129-不得姐
//
//  Created by wl on 2016/11/30.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLEssenceController.h"
#import "WLRecommendTagViewController.h"
#import "WLTopicViewController.h"
@interface WLEssenceController ()<UIScrollViewDelegate>
/**
 *标签栏
 */
@property (nonatomic,weak) UIView *titlesView;
/**
 *底部指示器
 */
@property (nonatomic,weak) UIView *indicatorView;

//选中的按钮
@property (nonatomic,weak) UIButton *selectedBtn;

//scrollview
@property (nonatomic,weak) UIScrollView *contentView;

@end

@implementation WLEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setUpNavBar];
    
    //设置背景色
    self.view.backgroundColor = WLRGBColor(223, 223, 223);
    
    //设置titleView
    [self setUpTitleView];
    
    //添加子控制器
    [self setUpChildVc];
    
    //设置scrollview
    [self setUpContentView];
    
}

//添加子控制器
- (void)setUpChildVc
{
    WLTopicViewController *all = [[WLTopicViewController alloc] init];
    [self addChildViewController:all];
    all.type = WLTopicTypeAll;
    
    WLTopicViewController *video = [[WLTopicViewController alloc] init];
    [self addChildViewController:video];
    video.type = WLTopicTypeVideo;
    
    WLTopicViewController *voice = [[WLTopicViewController alloc] init];
    [self addChildViewController:voice];
    voice.type = WLTopicTypeVoice;
    
    WLTopicViewController *picture = [[WLTopicViewController alloc] init];
    [self addChildViewController:picture];
    picture.type = WLTopicTypePicture;
    
    WLTopicViewController *word = [[WLTopicViewController alloc] init];
    word.type = WLTopicTypeWord;
    [self addChildViewController:word];
}

 //设置导航栏
- (void)setUpNavBar
{
   //设置标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置左边item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

//设置titleView
- (void)setUpTitleView
{
    UIView *titleView = [[UIView alloc] init];
    
    titleView.width = [UIScreen mainScreen].bounds.size.width;
    titleView.height = 35;
    titleView.y = 64;
    titleView.x = 0;
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    self.titlesView = titleView;
    [self.view addSubview:titleView];
    //设置底部红色指示器
    UIView *indicator = [[UIView alloc] init];
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.y = _titlesView.height - indicator.height;
    indicator.tag = -1;
    self.indicatorView = indicator;
    //添加内部按钮
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSInteger count = titles.count;
    CGFloat btnwidth = titleView.width / count;
    CGFloat btnheight = titleView.height;
    for (NSInteger i = 0; i<count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        btn.x = i * btnwidth;
        btn.y = 0;
        btn.width = btnwidth;
        btn.height = btnheight;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
//        //强制布局
//        [btn layoutIfNeeded];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        //监听按钮点击
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleView addSubview:btn];
        
        
        //默认选中第一个
        if (i == 0) {
            btn.enabled = NO;
            self.selectedBtn = btn;
            
            [btn.titleLabel sizeToFit];
            self.indicatorView.width = btn.titleLabel.width;
            CGPoint center = self.indicatorView.center;
            center.x = btn.center.x;
            self.indicatorView.center = center;
           
        }
    }
   
    [self.titlesView addSubview:indicator];
}

//设置底部红色指示器
- (void)redindicatorView
{
    UIView *indicator = [[UIView alloc] init];
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.y = _titlesView.height - indicator.height;
    self.indicatorView = indicator;
}

//titleView内部按钮点击
- (void)titleBtnClick:(UIButton *)btn
{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatorView.width = btn.titleLabel.width;
        CGPoint center = self.indicatorView.center;
        center.x = btn.center.x;
        self.indicatorView.center = center;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = btn.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

- (void)tagClick
{
    WLRecommendTagViewController *recoVC = [[WLRecommendTagViewController alloc] init];
    [self.navigationController pushViewController:recoVC animated:YES];
}

//设置scrollview
- (void)setUpContentView
{
    //让控制器不要调整scrollview的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:contentView atIndex:0];
    contentView.pagingEnabled = YES;
    
    //设置代理
    contentView.delegate = self;
    
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    //添加第一个子控制器
    [self scrollViewDidEndScrollingAnimation:contentView];
}



#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
   //获取到子控制器
   //索引
    CGPoint offset = scrollView.contentOffset;
    NSInteger index = offset.x / self.contentView.width;
    UITableViewController *vc = self.childViewControllers[index];
    //设置子控制器view的contentinsert
    CGFloat insertTop = CGRectGetMaxY(self.titlesView.frame);
    CGFloat insertBottom = self.tabBarController.tabBar.height;
    vc.view.x = offset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    vc.tableView.contentInset = UIEdgeInsetsMake(insertTop, 0, insertBottom, 0);
    //设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //按钮点击
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleBtnClick:self.titlesView.subviews[index]];
}
@end
