//
//  WKFriendCategory.h
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKFriendCategory : NSObject

/** 名字 */
@property (nonatomic,copy)NSString *name;
/** 数量 */
@property (nonatomic,assign)NSInteger count;
/** id */
@property (nonatomic,assign)NSInteger id;

/** 每个请求对应的用户数据 */
@property (nonatomic,strong)NSMutableArray *users;

/** 返回总数 */
@property (nonatomic,assign)NSInteger total;
/** 当前页码数 */
@property (nonatomic,assign)NSInteger currentPage;

@end
