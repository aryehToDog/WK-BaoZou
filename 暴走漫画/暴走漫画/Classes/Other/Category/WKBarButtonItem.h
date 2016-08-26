//
//  WKBarButtonItem.h
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKBarButtonItem : UIBarButtonItem

+ (instancetype)itemWithImage: (NSString *)image hightImage: (NSString *)hightImage action: (SEL)action target: (id)target;

@end
