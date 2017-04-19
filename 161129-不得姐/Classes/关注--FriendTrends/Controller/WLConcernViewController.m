//
//  WLConcernViewController.m
//  161129-不得姐
//
//  Created by wl on 2016/12/1.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLConcernViewController.h"
#import "WLCategoryCell.h"
#import "WLCategoryUsers.h"
#import "WLCategoryUserCell.h"
#import "WLCategory.h"
#import "WLCategoryUsers.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>

@interface WLConcernViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *categoryUsersTableView;
@property (strong,nonatomic)NSArray *categories;
//请求的参数
@property (strong,nonatomic)NSMutableDictionary *parameters;

//AFN管理员
@property (strong,nonatomic)AFHTTPSessionManager *manager;
@end

@implementation WLConcernViewController
static NSString * const categoryID = @"category";
static NSString * const userID = @"user";

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化TableView
    [self setUpTableView];
    
    //显示指示器
    [SVProgressHUD showWithStatus:@"加载ing"];
    
    //添加上拉加载控件
    [self setUpRefesh];
    
    //发送请求
    [self sendHTTPRequest];
}

//初始化TableView
- (void)setUpTableView
{
    //设置背景色
    self.view.backgroundColor = WLRGBColor(223, 223, 223);
    
    self.categoryTableView.backgroundColor = WLRGBColor(223, 223, 223);
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置标题
    self.navigationItem.title = @"推荐关注";
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.categoryUsersTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    //注册cell
        [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WLCategoryCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:categoryID];
    
    
        [self.categoryUsersTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WLCategoryUserCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:userID];
    //修改cell高度
    self.categoryUsersTableView.rowHeight = 70;
   
    
}

//发送请求
- (void)sendHTTPRequest
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"]) {
            WLCategory *category = [WLCategory categoryWithDict:dict];
            
            [temp addObject:category];
        }
        self.categories = temp;
        
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        [self.categoryUsersTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        
        [SVProgressHUD dismiss];
        
    }];

}

//添加上拉加载控件
- (void)setUpRefesh
{
    //下拉刷新控件
    self.categoryUsersTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    //上拉刷新控件
    self.categoryUsersTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.categoryUsersTableView.mj_footer.hidden = YES;
}

#pragma mark --加载用户数据
//记载最新用户数据
- (void)loadNewUsers
{
    NSIndexPath *index =  [self.categoryTableView indexPathForSelectedRow];
    WLCategory *category = self.categories[index.row];
    NSInteger userid = [category.userid integerValue];
    
    //当前页数
    category.currentPage = 1;
    //发送GET请求
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(userid);
    parameters[@"page"] = @(category.currentPage);
    self.parameters = parameters;
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //关闭指示器
        [SVProgressHUD dismiss];
        
        //字典转模型
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"]) {
            WLCategoryUsers *user = [WLCategoryUsers CategoryUsersWith:dict];
            
            [temp addObject:user];
        }
        //清除之前的数据
        [category.users removeAllObjects];
        
        [category.users addObjectsFromArray:temp];
        //保存总数
        category.total = [responseObject[@"total"] integerValue];
        
        //不是最后一次请求你
        if (self.parameters != parameters) return;
        
        //刷新表格
        [self.categoryUsersTableView reloadData];
        
        //结束刷新
        [self.categoryUsersTableView.mj_header endRefreshing];

        //判断有没有更多页
        if (category.users.count == category.total) {
            
            [self.categoryUsersTableView.mj_footer endRefreshingWithNoMoreData];
        }else
        {
            [self.categoryUsersTableView.mj_footer endRefreshing];
            [self.categoryUsersTableView.mj_footer resetNoMoreData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (self.parameters != parameters) return;
        //显示错误信息
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismiss];
        
        //结束刷新
        [self.categoryUsersTableView.mj_header endRefreshing];
        
    }];
}

//加载更多category对应的用户
- (void)loadMoreUsers
{
    NSIndexPath *index =  [self.categoryTableView indexPathForSelectedRow];
    WLCategory *category = self.categories[index.row];
    NSInteger userid = [category.userid integerValue];
    //发送GET请求
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(userid);
    parameters[@"page"] = @(++category.currentPage);
    self.parameters = parameters;
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //关闭指示器
        [SVProgressHUD dismiss];
        //字典转模型
        NSMutableArray *temps = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"]) {
            WLCategoryUsers *user = [WLCategoryUsers CategoryUsersWith:dict];
            
            [temps addObject:user];
        }
        
        [category.users addObjectsFromArray:temps];
        //不是最后一次请求
        if (self.parameters != parameters) return;
        
        //刷新表格
        [self.categoryUsersTableView reloadData];

        //让底部控件停止刷新
        if (category.users.count == category.total){
           [self.categoryUsersTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
             [self.categoryUsersTableView.mj_footer resetNoMoreData];
            [self.categoryUsersTableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (self.parameters != parameters) return;
        //显示错误信息
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismiss];
        //让底部控件停止刷新
        [self.categoryUsersTableView.mj_footer endRefreshing];
        
    }];
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        
        return self.categories.count;
        
    }else{
        
        NSIndexPath *indexPath =  [self.categoryTableView indexPathForSelectedRow];
        WLCategory *cat = self.categories[indexPath.row];
        self.categoryUsersTableView.mj_footer.hidden = (cat.users.count == 0);
        return cat.users.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        
        WLCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        cell.category = self.categories[indexPath.row];
        
        return cell;
    }else{
       
        WLCategoryUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
        NSIndexPath *index =  [self.categoryTableView indexPathForSelectedRow];
        WLCategory *cat = self.categories[index.row];

        cell.user = cat.users[indexPath.row];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WLCategory *category = self.categories[indexPath.row];
    if (category.users.count) {
        //曾经有数据
        [self.categoryUsersTableView reloadData];
        //停止所有刷新
        [self.categoryUsersTableView.mj_header endRefreshing];
        [self.categoryUsersTableView.mj_footer endRefreshing];
        
    }else{
        //显示指示器
        [SVProgressHUD showWithStatus:@"加载ing"];
        //赶紧刷新表格
        [self.categoryUsersTableView reloadData];
        
        //开始刷新
        [self.categoryUsersTableView.mj_header beginRefreshing];

    }
   
}
//控制器销毁处理
- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}

@end
