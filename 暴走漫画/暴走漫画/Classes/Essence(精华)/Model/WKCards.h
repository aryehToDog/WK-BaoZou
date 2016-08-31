//
//  WKCards.h
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/30.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCards : NSObject

/** 图像 */
@property (nonatomic,copy)NSString *profile_image;
/** 名字 */
@property (nonatomic,copy)NSString *screen_name;
/** 时间 */
@property (nonatomic,copy)NSString *create_time;
/** 段子内容 */
@property (nonatomic,copy)NSString *text;
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
/** 定义一个属性用来标记不同页面显示的段子内容 */
@property (nonatomic,assign)WKCardsType type;
/** 内容高度 */
@property (nonatomic,assign)CGFloat height;
/** 内容宽度 */
@property (nonatomic,assign)CGFloat width;
/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;



/** 返回行高 */
@property (nonatomic,assign,readonly)CGFloat cellHeight;
/** 返回图片frame */
@property (nonatomic,assign,readonly)CGRect pictureF;
/** 判断是否为大图 */
@property (nonatomic,assign,getter=isBigPicture)BOOL bigPicture;
/** 显示的进度 */
@property (nonatomic,assign)CGFloat progress;

@end
