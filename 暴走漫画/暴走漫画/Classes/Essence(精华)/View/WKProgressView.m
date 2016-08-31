//
//  WKProgressView.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/9/1.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKProgressView.h"

@implementation WKProgressView

- (void)awakeFromNib {

    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
    
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {

    [super setProgress:progress animated:animated];
    //设置文字显示比例
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    
    //带负号的进度文字全部替换
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];

}

@end
