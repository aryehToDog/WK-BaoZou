//
//  WKEssenceTagViewController.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/28.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKEssenceTagViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "WKEssenceTageCell.h"
#import <MJExtension.h>
#import "WKEssenceTage.h"
@interface WKEssenceTagViewController ()

@property (nonatomic,strong)NSArray *tages;

@end

const static NSString *tagId = @"tage";
@implementation WKEssenceTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置tableView
    [self setupTableView];
    
    //发送请求数据
    [self setupRequest];
}

- (void)setupTableView {

    //设置标题
    self.title = @"推荐标签";
    
    //注册id
    [self.tableView registerNib:[UINib nibWithNibName:@"WKEssenceTageCell" bundle:nil] forCellReuseIdentifier:tagId];
    
    //设置行高
    self.tableView.rowHeight = 70;
    
    //设置背景颜色
    self.view.backgroundColor = WKGrobeColor;


}

- (void)setupRequest {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"friend_recommend";
    parame[@"c"] = @"user";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parame progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //隐藏HUD
        [SVProgressHUD dismiss];
        
        //字典转模型
        self.tages = [WKEssenceTage mj_objectArrayWithKeyValuesArray:responseObject[@"top_list"]];
        
        WKLog(@"%@",responseObject);
        //刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        WKLog(@"%@",error);
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        
    }];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WKEssenceTageCell *cell = [tableView dequeueReusableCellWithIdentifier:tagId];
    
    cell.tage = self.tages[indexPath.row];
    
    return cell;
}



@end
