//
//  WKCardsVoiceView.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/9/4.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKCardsVoiceView.h"
#import <UIImageView+WebCache.h>
#import "WKCards.h"
#import "WKShowPictureViewController.h"
@interface WKCardsVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *lableCount;
@property (weak, nonatomic) IBOutlet UILabel *lableTime;

@end

@implementation WKCardsVoiceView

+ (instancetype)voiceView {

        return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

}

- (void)awakeFromNib {
    
    //取消自动布局
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //图片进行交互
    self.imageView.userInteractionEnabled = YES;
    
    //添加一个点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBtn)];
    
    [self.imageView addGestureRecognizer:tap];
    
}

- (void)clickBtn{
    
    WKLog(@"%s",__func__);
    
    WKShowPictureViewController *showVc = [[WKShowPictureViewController alloc]init];
    
    showVc.cards = self.cards;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVc animated:YES completion:nil];
    
}

- (void)setCards:(WKCards *)cards {
    
    _cards = cards;
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cards.large_image]];
    
    //设置播放时间
    NSInteger send = cards.voicetime / 60;
    NSInteger end = send / 60;
    self.lableTime.text = [NSString stringWithFormat:@"%02zd:%02zd",send,end];
    
    //设置播放数
    self.lableCount.text = [NSString stringWithFormat:@"%zd播放",cards.playcount];

}

@end
