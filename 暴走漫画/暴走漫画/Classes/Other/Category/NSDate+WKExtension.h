//
//  NSDate+WKExtension.h
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/30.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WKExtension)
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
@end
