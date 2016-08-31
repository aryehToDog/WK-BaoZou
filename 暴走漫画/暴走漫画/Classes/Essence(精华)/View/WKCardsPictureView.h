//
//  WKCardsPictureView.h
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/31.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKCards;
@interface WKCardsPictureView : UIView

@property (nonatomic,strong)WKCards *cards;

+ (instancetype)pictureView;

@end
