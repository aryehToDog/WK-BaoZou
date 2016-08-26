//
//  WKBarButtonItem.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKBarButtonItem.h"

@implementation WKBarButtonItem

+ (instancetype)itemWithImage: (NSString *)image hightImage: (NSString *)hightImage action: (SEL)action target: (id)target {

    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc]initWithCustomView:btn];

}

@end
