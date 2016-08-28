//
//  WKloginReguistBtn.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/28.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKloginReguistBtn.h"

@implementation WKloginReguistBtn


- (void)awakeFromNib {

        [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame {

    if ([super initWithFrame:frame]) {
        
        [self setupUI];
    }

    return self;
}


- (void)setupUI {
    
    //文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)layoutSubviews {

    [super layoutSubviews];
    //布局图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    //布局文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
