//
//  WKTabBarController.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/26.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTabBarController.h"
#import "WKEssenceViewController.h"
#import "WKNewViewController.h"
#import "WKFriendTrendsViewController.h"
#import "WKMeViewController.h"
#import "WKNavViewController.h"
#import "WKTabBar.h"

@interface WKTabBarController ()

@end

@implementation WKTabBarController

+ (void)initialize {

    //设置外观对象
    UITabBarItem *bar = [UITabBarItem appearance];
    
    NSMutableDictionary *normalDict = [NSMutableDictionary dictionary];
    normalDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    normalDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *highlightedDict = [NSMutableDictionary dictionary];
    highlightedDict[NSFontAttributeName] = normalDict[NSFontAttributeName];
    highlightedDict[NSBackgroundColorAttributeName] = [UIColor darkGrayColor];
    
    [bar setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    [bar setTitleTextAttributes:highlightedDict forState:UIControlStateSelected];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self setUpVc];
    
    //替换系统TabBar
    [self setValue:[[WKTabBar alloc]init] forKeyPath:@"tabBar"];
}

- (void)setUpVc {

    //创建精华控制器
    WKEssenceViewController *EssenceVc = [[WKEssenceViewController alloc]init];
    
    [self setUpChildVc:EssenceVc title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    //创建新帖控制器
    WKNewViewController *NewVc = [[WKNewViewController alloc]init];
    [self setUpChildVc:NewVc title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    //创建关注控制器
    WKFriendTrendsViewController *FriendTrendsVc = [[WKFriendTrendsViewController alloc]init];
    [self setUpChildVc:FriendTrendsVc title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    //创建我的控制器
    WKMeViewController *MeVc = [[WKMeViewController alloc]init];
    [self setUpChildVc:MeVc title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
}

- (void)setUpChildVc: (UIViewController *)vc title: (NSString *)title image: (NSString *)image selectedImage: (NSString *)selectedImage {

    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    WKNavViewController *nav = [[WKNavViewController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];

}

@end
