//
//  WKFriendTrendsViewController.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKFriendTrendsViewController.h"
#import "WKFriendViewController.h"
#import "WKloginReguistViewController.h"
@interface WKFriendTrendsViewController ()

@end

@implementation WKFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WKGrobeColor;
    
    //设置导航条内容
    [self setUpItem];
    
}

- (void)setUpItem {
    
    //设置导航条View
    self.navigationItem.title = @"我的关注";
    
    //设置item
    self.navigationItem.leftBarButtonItem = [WKBarButtonItem itemWithImage:@"friendsRecommentIcon" hightImage:@"friendsRecommentIcon-click" action:@selector(clickBtn) target:self];
    
}

- (void)clickBtn {

    WKLog(@"%s",__func__);
    
    WKFriendViewController *friendVc = [[WKFriendViewController alloc]init];
    [self.navigationController pushViewController:friendVc animated:YES];
}


///
///
/// @param sender 登陆注册页面
- (IBAction)loginReguist:(id)sender {
    
    WKloginReguistViewController *loginVc = [[WKloginReguistViewController alloc]init];
    
    [self presentViewController:loginVc animated:YES completion:nil];
}



@end
