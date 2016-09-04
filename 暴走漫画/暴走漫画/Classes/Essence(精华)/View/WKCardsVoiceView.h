//
//  WKCardsVoiceView.h
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/9/4.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKCards;
@interface WKCardsVoiceView : UIView
@property (nonatomic,strong)WKCards *cards;

+ (instancetype)voiceView;
@end
