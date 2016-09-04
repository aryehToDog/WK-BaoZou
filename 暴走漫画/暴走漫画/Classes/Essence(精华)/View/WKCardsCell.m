//
//  WKCardsCell.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/30.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKCardsCell.h"
#import <UIImageView+WebCache.h>
#import "WKCards.h"
#import "WKCardsPictureView.h"
#import "WKCardsVoiceView.h"
#import "WKCardsVideoView.h"
@interface WKCardsCell ()
/** 图像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
/** 名字 */
@property (weak, nonatomic) IBOutlet UILabel *screenName;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTime;
/** 点赞 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
/** 聊天 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/** VIP认证 */
@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;
/** 段子文字 */
@property (weak, nonatomic) IBOutlet UILabel *cardsLabel;
/** 图片模块的View */
@property (nonatomic,strong)WKCardsPictureView *cardsPictureView;
/** 音频模块的View */
@property (nonatomic,strong)WKCardsVoiceView *cardsVoiceView;
/** 视频模块的View */
@property (nonatomic,strong)WKCardsVideoView *cardsVideoView;

@end

@implementation WKCardsCell

- (WKCardsPictureView *)cardsPictureView {

    if (!_cardsPictureView) {
        
        //将cardsPictureView 添加到cell中
        WKCardsPictureView *cardsPictureView = [WKCardsPictureView pictureView];
        [self.contentView addSubview:cardsPictureView];
        
        _cardsPictureView = cardsPictureView;
    }

    return _cardsPictureView;
}
- (WKCardsVoiceView *)cardsVoiceView {
    
    if (!_cardsVoiceView) {
        
        //将cardsPictureView 添加到cell中
        WKCardsVoiceView *cardsVoiceView = [WKCardsVoiceView voiceView];
        [self.contentView addSubview:cardsVoiceView];
        
        _cardsVoiceView = cardsVoiceView;
    }
    
    return _cardsVoiceView;
}
- (WKCardsVideoView *)cardsVideoView {
    
    if (!_cardsVideoView) {
        
        //将cardsPictureView 添加到cell中
        WKCardsVideoView *cardsVideoView = [WKCardsVideoView videoView];
        [self.contentView addSubview:cardsVideoView];
        
        _cardsVideoView = cardsVideoView;
    }
    
    return _cardsVideoView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //设置cell的背景
    UIImageView *bg = [[UIImageView alloc]init];
    bg.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bg;
    
    //取消cell的选中样式
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


//从写set方法进行赋值
- (void)setCards:(WKCards *)cards {

    //设置图像
    [self.profileImage sd_setImageWithURL:[NSURL URLWithString:cards.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    //设置昵称
    self.screenName.text = cards.screen_name;
    
    //设置时间
    self.createTime.text = cards.create_time;
    
    //设置按钮
    [self setupWithButton:self.dingBtn count:cards.ding placehodler:@"顶"];
    
    [self setupWithButton:self.caiBtn count:cards.cai placehodler:@"踩"];
    
    [self setupWithButton:self.repostBtn count:cards.repost placehodler:@"分享"];
    
    [self setupWithButton:self.commentBtn count:cards.comment placehodler:@"评论"];
    
    //判断是否是vip认证
    self.vipIcon.hidden = !cards.isSina_v;
    
    //设置段子文字
    self.cardsLabel.text = cards.text;
    
    //判断当前选择模块所要显示的内容
    if (cards.type == WKCardsTypePicture) {   //假如当前模块为图片模块
        self.cardsPictureView.hidden = NO;
        self.cardsPictureView.cards = cards;
        //frame模型进行赋值
        self.cardsPictureView.frame = cards.pictureF;
        self.cardsVoiceView.hidden = YES;
        self.cardsVideoView.hidden = YES;
        
    } else if (cards.type == WKCardsTypeVoice) {  //假如当前模块为声音模块
        self.cardsVoiceView.hidden = NO;
        self.cardsVoiceView.cards = cards;
        //frame模型进行赋值
        self.cardsVoiceView.frame = cards.VoiceF;
        self.cardsPictureView.hidden = YES;
        self.cardsVideoView.hidden = YES;
    
    }else if (cards.type == WKCardsTypeVideo) {  //假如当前模块为视频模块
        self.cardsVideoView.hidden = NO;
        self.cardsVideoView.cards = cards;
        //frame模型进行赋值
        self.cardsVideoView.frame = cards.VideoF;
        self.cardsPictureView.hidden = YES;
        self.cardsVoiceView.hidden = YES;
    
    }else {                                     //全部模块
    
        self.cardsPictureView.hidden = YES;
        self.cardsVoiceView.hidden = YES;
        self.cardsVideoView.hidden = YES;
    }
    
}

//设置按钮
- (void)setupWithButton: (UIButton *)button count: (NSInteger)count placehodler: (NSString *)placehodler{
    
    if (count > 10000) {
        placehodler = [NSString stringWithFormat:@"%.1f万人",count / 10000.0];
        
    }else if (count > 0){
        
        placehodler = [NSString stringWithFormat:@"%zd",count];
    }
    
    
    [button setTitle:placehodler forState:UIControlStateNormal];

}
//设置frame的距离
- (void)setFrame:(CGRect)frame {
    
    //设置间距
    NSInteger margin = 10;
    frame.origin.x = margin;
    frame.size.width = frame.size.width - 2 * margin;
    frame.size.height = frame.size.height - margin;
    frame.origin.y += margin;
    [super setFrame:frame];
}

@end
