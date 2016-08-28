//
//  WKguideView.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/28.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKguideView.h"

@interface WKguideView ()

@end

@implementation WKguideView

+ (void)show {

    //获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    //获取以前版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults]valueForKey:@"CFBundleShortVersionString"];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {   //显示引导界面
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        WKguideView *guide = [WKguideView guideView];
        guide.frame = window.bounds;
        [window addSubview:guide];
        
        //保存版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"CFBundleShortVersionString"];
        //同步数据
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    
    
    

}


// 初始化
+ (instancetype)guideView {
    
    return [[[NSBundle mainBundle]loadNibNamed:@"WKguideView" owner:nil options:nil] lastObject];
    
}

- (IBAction)dissBtn {
    
    //移除引导界面
    [self removeFromSuperview];
}


@end
