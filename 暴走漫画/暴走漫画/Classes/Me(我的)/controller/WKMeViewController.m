//
//  WKMeViewController.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKMeViewController.h"

@interface WKMeViewController ()

@end

@implementation WKMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WKGrobeColor;
    
    //设置导航条内容
    [self setUpItem];
    
}

- (void)setUpItem {
    
    //设置导航条View
    self.navigationItem.title = @"我的";
    
    //设置item
    WKBarButtonItem *settingItem = [WKBarButtonItem itemWithImage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" action:@selector(clickSetting) target:self];
    
    WKBarButtonItem *moonItem = [WKBarButtonItem itemWithImage:@"mine-moon-icon" hightImage:@"mine-moon-icon-click" action:@selector(clickMoonItem) target:self];
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
}
- (void)clickSetting {
    
    WKLog(@"%s",__func__);
}

- (void)clickMoonItem {
    
    WKLog(@"%s",__func__);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
