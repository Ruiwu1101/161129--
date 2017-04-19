//
//  WLTopicViewController.m
//  161129-不得姐
//
//  Created by wl on 2016/12/10.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLTopicViewController.h"

#import <MJRefresh.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "WLTopics.h"
#import "WLTopicCell.h"
@interface WLTopicViewController ()
//帖子的数量
@property (nonatomic,strong) NSMutableArray *topics;
//页数
@property (nonatomic,assign) NSInteger page;
//最大时间
@property (nonatomic,copy) NSString *maxtime;

//上一次的请求参数
@property (nonatomic,strong) NSDictionary *parameters;
@end

@implementation WLTopicViewController
//cell的标识
static NSString *const WLTopicId = @"topic";
- (NSMutableArray *)topics
{
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加刷新控件
    [self setUpRefesh];
    
    //注册cell
    [self registerCell];
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}

//注册cell
- (void)registerCell
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WLTopicCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:WLTopicId];
}
//加载数据
- (void)setUpRefesh
{
    //下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    [self.tableView.mj_header setAutomaticallyChangeAlpha:YES];
    [self.tableView.mj_header beginRefreshing];
    
    //上拉加载控件
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}
//加载最新帖子
- (void)loadNewTopic
{
    //结束上拉
    [self.tableView.mj_footer endRefreshing];
    //请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    self.parameters = parameters;
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"https://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.parameters != parameters) return;
        
        //字典 -> 模型
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"]) {
            WLTopics *topic = [WLTopics topicWithDict:dict];
            [temp addObject:topic];
        }
        self.topics = temp;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新控件
        [self.tableView.mj_header endRefreshing];
        //清空页码
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parameters != parameters) return;
        //结束刷新控件
        [self.tableView.mj_header endRefreshing];
    }];
}

//加载更多数据
- (void)loadMoreTopic
{
    //结束下拉
    [self.tableView.mj_header endRefreshing];
    
    self.page++;
    //请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    parameters[@"page"] = @(self.page);
    self.parameters = parameters;
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"https://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.parameters != parameters) return;
        //字典 -> 模型
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"]) {
            WLTopics *topic = [WLTopics topicWithDict:dict];
            [temp addObject:topic];
        }
        [self.topics addObjectsFromArray:temp];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新控件
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parameters != parameters) return;
        //结束刷新控件
        [self.tableView.mj_footer endRefreshing];
        //恢复页码
        self.page--;
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WLTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:WLTopicId];
    
    cell.topic = self.topics[indexPath.row];
    return cell;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLTopics *topic = self.topics[indexPath.row];
    
    return topic.cellHieght;
}
@end
