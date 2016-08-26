//
//  WKNavViewController.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKNavViewController.h"

@interface WKNavViewController ()

@end

@implementation WKNavViewController

+ (void)initialize {

    UINavigationBar *bar = [UINavigationBar appearance];
    //设备nav背景颜色
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.childViewControllers.count > 0) {
        
        //设置返回箭头及文字
        UIButton *backBtn = [[UIButton alloc]init];
        [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
        [backBtn sizeToFit];
        //设置距离左边的距离
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
    }

    [super pushViewController:viewController animated:animated];
    
}

- (void)backBtn {

    [self popViewControllerAnimated:YES];
}

@end
