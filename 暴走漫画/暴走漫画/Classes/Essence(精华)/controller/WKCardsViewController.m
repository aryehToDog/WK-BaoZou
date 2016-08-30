//
//  WKCardsViewController.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/28.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKCardsViewController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import "WKCards.h"
#import <MJExtension.h>
#import "WKCardsCell.h"

@interface WKCardsViewController ()

//定义一个段子数组
@property (nonatomic,strong)NSMutableArray *cards;
//当前页码数
@property (nonatomic,assign)NSInteger currentPage;
//字典请求参数(防止用户请求超时)
@property (nonatomic,strong)NSDictionary *parames;
//获取下一页帖子内容页数
@property (nonatomic,strong)NSString *maxtime;
@end

@implementation WKCardsViewController

static NSString * const ID = @"cards";

- (NSMutableArray *)cards {
    
    if (_cards == nil) {
        
        _cards = [NSMutableArray array];
    }
    return _cards;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView的属性
    [self setupTableView];
    
    //设置刷新控件
    [self setupRefresh];
    
    
}

//设置tableView的属性
- (void)setupTableView {
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //设置vc的内边距
    CGFloat top = WKTitilesViewH + WKTitilesViewY;
    CGFloat botton = self.tabBarController.tabBar.height;
    
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, botton, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"WKCardsCell" bundle:nil] forCellReuseIdentifier:ID];
    
}

- (void)setupRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNews)];
    
    //自动改变下拉的透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //开始刷新
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMores)];
}

//下拉刷新
- (void)loadNews {
    
    //来到下拉就停止上拉
    [self.tableView.mj_footer endRefreshing];
    
    //发送请求获取数据
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] =@"list";
    parame[@"c"] =@"data";
    parame[@"type"] = @(self.type);
    self.parames = parame;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parame progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        if (self.parames != parame) return ;
        
        //保存帖子页码数
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典数组转成模型数组
        self.cards = [WKCards mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //进行数据拼接
        //        [self.cards addObjectsFromArray:cardArray];
        
        [self.tableView reloadData];
        //停止刷新
        [self.tableView.mj_header endRefreshing];
        
        //每次下拉刷新成功设置当前页码数为0
        self.currentPage = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parames != parame) return ;
        
        WKLog(@"%@",error);
        //停止刷新
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}


//上拉加载
- (void)loadMores {
    
    //来到上拉就停止下拉
    [self.tableView.mj_header endRefreshing];
    
    self.currentPage ++;
    //发送请求获取数据
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] =@"list";
    parame[@"c"] =@"data";
    parame[@"type"] =@(self.type);
    parame[@"page"] = @(self.currentPage);
    parame[@"maxtime"] = self.maxtime;
    self.parames = parame;
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parame progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        if (self.parames != parame) return ;
        
        //保存帖子页码数
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组转成模型数组
        NSArray *cardArray = [WKCards mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //进行数据拼接
        [self.cards addObjectsFromArray:cardArray];
        
        [self.tableView reloadData];
        
        //结束上拉刷新
        [self.tableView.mj_footer endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parames != parame) return ;
        WKLog(@"%@",error);
        //停止刷新
        [self.tableView.mj_footer endRefreshing];
        
        //页码数减一
        self.currentPage --;
    }];
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //进入隐藏foot刷新
    self.tableView.mj_footer.hidden = (self.cards.count == 0);
    
    return self.cards.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WKCardsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.cards = self.cards[indexPath.row];
    
    return cell;
}

//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

@end
