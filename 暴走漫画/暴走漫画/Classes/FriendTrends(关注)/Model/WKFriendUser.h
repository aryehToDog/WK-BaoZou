//
//  WKFriendUser.h
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKFriendUser : NSObject

/** 姓名 */
@property (nonatomic,copy)NSString *screen_name;
/** 粉丝数 */
@property (nonatomic,assign)NSInteger fans_count;
/** 图片 */
@property (nonatomic,copy)NSString *header;

@end
