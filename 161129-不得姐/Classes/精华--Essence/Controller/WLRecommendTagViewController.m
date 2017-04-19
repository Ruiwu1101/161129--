//
//  WLRecommendTagViewController.m
//  161129-不得姐
//
//  Created by wl on 2016/12/5.
//  Copyright © 2016年 wl. All rights reserved.
//

#import "WLRecommendTagViewController.h"
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import "WLRecommengTag.h"
#import "WLRecommendTagCell.h"
@interface WLRecommendTagViewController ()
@property (nonatomic, strong)NSMutableArray *RecommengTags;
@end

//cell的标识
static NSString *const WLRecommendTag = @"RecommengTag";

@implementation WLRecommendTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.navigationItem.title = @"推荐关注";
    
    //设置行高
    self.tableView.rowHeight = 70;
    
    //设置背景色
    self.view.backgroundColor = WLRGBColor(223, 223, 223);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [self registerCell];
    
    //显示指示器
    [SVProgressHUD showWithStatus:@"拼命加载中🐂"];
    
    //发送请求
    [self loadTags];
    
}

//注册cell
- (void)registerCell
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WLRecommendTagCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:WLRecommendTag];
}

//发送请求
- (void)loadTags
{
    //请求的参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    [[AFHTTPSessionManager manager] GET:@"https://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //字典转模型
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            WLRecommengTag *recoTag = [WLRecommengTag recommendTagWithDict:dict];
            
            [temp addObject:recoTag];
            
        }
        
        self.RecommengTags = temp;
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.RecommengTags.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WLRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:WLRecommendTag];
    
    cell.recoTag = self.RecommengTags[indexPath.row];
    
    return cell;
}



@end
