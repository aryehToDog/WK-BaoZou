//
//  WKEssenceTage.h
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/28.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKEssenceTage : NSObject
/** 头像 */
@property (nonatomic,copy)NSString *header;
/** 名字 */
@property (nonatomic,copy)NSString *screen_name;
/** 订阅数 */
@property (nonatomic,assign)NSInteger fans_count;
@end
