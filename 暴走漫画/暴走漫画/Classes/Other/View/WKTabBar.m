//
//  WKTabBar.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTabBar.h"

@interface WKTabBar ()

@property (nonatomic,weak)UIButton *redBtn;

@end

@implementation WKTabBar

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        //创建按钮tabBar_publish_icon
        UIButton *redBtn = [[UIButton alloc]init];
        [redBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [redBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        [self addSubview:redBtn];
        self.redBtn = redBtn;
        
    }

    return self;
}


- (void)layoutSubviews {

    [super layoutSubviews];
    
    //从新布局子控件
    self.redBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    [self.redBtn sizeToFit];
    
    CGFloat btnY = 0;
    CGFloat btnW = self.width / 5;
    CGFloat btnH = self.height;
    NSInteger index = 0;
    
    
    for (UIView *btn in self.subviews) {
        
        if (![btn isKindOfClass:[UIControl class]] || btn == self.redBtn) continue;
        
        CGFloat btnX = index > 1 ? (index + 1 )* btnW :index * btnW;

        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        index ++;
    }

}

@end
