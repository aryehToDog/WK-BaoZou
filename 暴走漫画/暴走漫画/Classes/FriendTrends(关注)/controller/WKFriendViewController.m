//
//  WKFriendViewController.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKFriendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "WKFriendCategoryCell.h"
#import "WKFriendCategory.h"
#import <MJExtension.h>
#import "WKFriendUser.h"
#import "WKFriendUserCell.h"
@interface WKFriendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 定义一个分类数组 */
@property (nonatomic,strong)NSArray *categorys;
/** 定义一个用户数组 */
@property (nonatomic,strong)NSArray *users;

@end

const static NSString *categoryId = @"category";
const static NSString *userId = @"user";

@implementation WKFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView基本属性
    [self setUpTableView];
    
    //设置左边数据请求
    [self setUpleftRequest];
    
    
    
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
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parame progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        //字典数组转换成模型数组
        self.categorys = [WKFriendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        WKLog(@"%@",responseObject);
        
        [self.categoryTableView reloadData];
        //显示第一个标签
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求服务加载失败"];
        WKLog(@"请求失败");
        
    }];


}

#pragma mark - UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.categoryTableView) {
        return self.categorys.count;
    } else {
        
        return self.users.count;
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
        WKFriendUser *user = self.users[indexPath.row];
        
        cell.uesr = user;
        
        return cell;

    
    }

}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    WKFriendCategory *category = self.categorys[indexPath.row];
    
    //发送左边数据请求
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"list";
    parame[@"c"] = @"subscribe";
    parame[@"category_id"] = @(category.id);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parame progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典转模型
        self.users = [WKFriendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        WKLog(@"%@",responseObject);
        
        [self.userTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        WKLog(@"请求数据失败");
        
    }];

}


@end
