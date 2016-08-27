//
//  WKFriendViewController.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//
/**
 1.目前只能显示1页数据
 2.重复发送请求
 3.网络慢带来的细节问题
 */

#import "WKFriendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "WKFriendCategoryCell.h"
#import "WKFriendCategory.h"
#import <MJExtension.h>
#import "WKFriendUser.h"
#import "WKFriendUserCell.h"
#import <MJRefresh.h>

#define WKCategory self.categorys[self.categoryTableView.indexPathForSelectedRow.row]
@interface WKFriendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 防止请求控制器销毁问题 */
@property (nonatomic,strong)AFHTTPSessionManager *manager;
/** 防止请求防止重复 */
@property (nonatomic,strong)NSMutableDictionary *parame;

/** 定义一个分类数组 */
@property (nonatomic,strong)NSArray *categorys;

@end

const static NSString *categoryId = @"category";
const static NSString *userId = @"user";

@implementation WKFriendViewController

- (AFHTTPSessionManager *)manager {

    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView基本属性
    [self setUpTableView];
    
    //设置左边数据请求
    [self setUpleftRequest];
    
    //设置刷新控件
    [self setUpRefresh];
}


- (void)setUpTableView {

    self.navigationItem.title = @"推荐关注";
    
    //设置行高
    self.userTableView.rowHeight = 70;
    
    //取消自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    //注册Cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:@"WKFriendCategoryCell" bundle:nil] forCellReuseIdentifier:categoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:@"WKFriendUserCell" bundle:nil] forCellReuseIdentifier:userId];
    
    self.categoryTableView.backgroundColor = WKGrobeColor;


}

- (void)setUpleftRequest {

    //设置蒙版
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送左边数据请求
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"category";
    parame[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parame progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        //字典数组转换成模型数组
        self.categorys = [WKFriendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        WKLog(@"%@",responseObject);
        
        [self.categoryTableView reloadData];
        //显示第一个标签
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        //开始刷新
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求服务加载失败"];
        WKLog(@"请求失败");
        
    }];


}

- (void)setUpRefresh {

    //设置下拉刷新更多数据
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewMessage)];
    
    //设置上拉刷新更多数据
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreMessage)];

    self.userTableView.mj_footer.hidden = YES;
}

//下拉刷新更多数据
- (void)loadNewMessage {

    WKFriendCategory *category = WKCategory;
    
    //设置页码数
    category.currentPage = 1;
    
    //发送右边数据请求
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"list";
    parame[@"c"] = @"subscribe";
    parame[@"category_id"] = @(category.id);
    //页码数
    parame[@"page"] = @(category.currentPage);
    self.parame = parame;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parame progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典转模型
        NSArray *user = [WKFriendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //清空以前的数据
        [category.users removeAllObjects];
        //拼接模型数据
        [category.users addObjectsFromArray:user];
        
        if (self.parame != parame) return;
        
        //保存总用户数
        category.total = [responseObject[@"total"] integerValue];
        
        [self.userTableView reloadData];
        
        //结束下拉刷新
        [self.userTableView.mj_header endRefreshing];
        
        [self cheakFootState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        
        [self.userTableView.mj_header endRefreshing];
    }];

    

}

//上拉刷新更多数据
- (void)loadMoreMessage {

    WKFriendCategory *category = WKCategory;
    
    //发送右边数据请求
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"list";
    parame[@"c"] = @"subscribe";
    parame[@"category_id"] = @(category.id);
    //页码数
    parame[@"page"] = @(++category.currentPage);
    self.parame = parame;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parame progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典转模型
        NSArray *user = [WKFriendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //拼接模型数据
        [category.users addObjectsFromArray:user];
  
        if (self.parame != parame) return ;
  
        [self.userTableView reloadData];
        
        [self cheakFootState];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        
        [self.userTableView.mj_footer endRefreshing];
    }];

}

//检查foot是否显示及结束
- (void)cheakFootState {

    WKFriendCategory *category = WKCategory;
    
    //让底部控件结束刷新
    self.userTableView.mj_footer.hidden = (category.users.count == 0);
    
    //让底部控件进行刷新
    if (category.total == category.users.count ) {
        //没有数据进行刷新
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        
    }else {
        //结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }


}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    if (tableView == self.categoryTableView) {
        return self.categorys.count;
    } else {
        //左边被选中的类型
//        WKFriendCategory *category = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
//        return category.users.count;
        return [WKCategory users].count;
    }
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.categoryTableView) {
    
        WKFriendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryId];
        WKFriendCategory *category = self.categorys[indexPath.row];
        
        cell.category = category;
        
        return cell;
    } else {
    
        WKFriendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userId];
        
//        WKFriendCategory *category = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
        WKFriendUser *user = [WKCategory users][indexPath.row];
        
        cell.uesr = user;
        
        return cell;

    
    }

}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //每次结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    WKFriendCategory *category = self.categorys[indexPath.row];
    
    //判断是否发送请求
    if (category.users.count) {
     //直接显示数据
        [self.userTableView reloadData];
        
    } else {
      //清空以前加载的数据
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header beginRefreshing];
    }
    
    
}

//取消数据请求
- (void)dealloc {

    [self.manager.operationQueue cancelAllOperations];
}


@end
