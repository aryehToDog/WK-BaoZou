//
//  WKloginReguistViewController.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/28.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKloginReguistViewController.h"

@interface WKloginReguistViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstaint;


@end

@implementation WKloginReguistViewController

///
///
/// @param sender 返回按钮
- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//切换注册按钮
- (IBAction)reguistBtn:(UIButton *)sender {
    
    //结束编辑
    [self.view endEditing:YES];
    
    if (self.leftConstaint.constant == 0) {
        
        //切换注册
        self.leftConstaint.constant = - self.view.width;
        //改变文字
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }else {
    
        //切换登陆
        self.leftConstaint.constant = 0;
        //改变文字
        [sender setTitle:@"已有账号?" forState:UIControlStateNormal];

    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginBtn:(UIButton *)sender {
    
    //圆角设置
//    sender.layer.cornerRadius = 5;
//    sender.clipsToBounds = YES;
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//控制键盘弹下
- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}


@end
