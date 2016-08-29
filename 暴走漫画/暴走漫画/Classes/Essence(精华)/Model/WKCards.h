//
//  WKCards.h
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/30.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKCards : NSObject

/** 图像 */
@property (nonatomic,copy)NSString *profile_image;
/** 名字 */
@property (nonatomic,copy)NSString *screen_name;
/** 时间 */
@property (nonatomic,copy)NSString *create_time;
/** 点赞 */
@property (nonatomic,assign)NSInteger ding;
/** 踩 */
@property (nonatomic,assign)NSInteger cai;
/** 分享 */
@property (nonatomic,assign)NSInteger repost;
/** 聊天 */
@property (nonatomic,assign)NSInteger comment;
/** 会员认证 */
@property (nonatomic,assign,getter=isSina_v)BOOL sina_v;




@end
