//
//  WKTextField.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/28.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTextField.h"

@implementation WKTextField

- (void)awakeFromNib {

    //设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    [self resignFirstResponder];
}

//成为第一响应者
- (BOOL)becomeFirstResponder {
    
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    
    return [super becomeFirstResponder];
}

//取消第一响应者
- (BOOL)resignFirstResponder {

    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    return [super resignFirstResponder];

}
@end
