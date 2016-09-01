//
//  WKCardsPictureView.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/31.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKCardsPictureView.h"
#import <UIImageView+WebCache.h>
#import "WKCards.h"
#import "WKProgressView.h"
#import <SVProgressHUD.h>
#import "WKShowPictureViewController.h"
@interface WKCardsPictureView ()
/** 图片内容 */
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
/** gif图片 */
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
/** 显示进度条 */
@property (weak, nonatomic) IBOutlet WKProgressView *progressView;
/** 大图显示按钮 */
@property (weak, nonatomic) IBOutlet UIButton *showBugPicture;

@end

@implementation WKCardsPictureView

+ (instancetype)pictureView {

    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

}

- (void)awakeFromNib {

    //取消自动布局
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //图片进行交互
    self.pictureImageView.userInteractionEnabled = YES;
    
    //添加一个点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBtn)];
    
    [self.pictureImageView addGestureRecognizer:tap];

}


- (void)setCards:(WKCards *)cards {

    _cards = cards;
    
    //刷新纪录上一次保存的进度
    [self.progressView setProgress:cards.progress animated:NO];
    
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:cards.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        cards.progress = 1.0 * receivedSize / expectedSize;
        //显示进度
        [self.progressView setProgress:cards.progress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        
        if (!cards.isBigPicture) return ;
        
        //设置大图显示在最上面的部分
        
        //开启上下文
        UIGraphicsBeginImageContextWithOptions(cards.pictureF.size, YES, 0.0);
        
        //进行绘制
        CGFloat imageW = cards.pictureF.size.width;
        CGFloat imageH = imageW * image.size.height / image.size.width;
        
        [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
        
        //获取一张新的图片
        self.pictureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        //关闭上下文
        UIGraphicsEndImageContext();
        
    }];
    

    //判断是否为gif图片
    NSString *extension = cards.large_image.pathExtension;
    self.gifImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    //判断是否为大图
    if (cards.isBigPicture) {    //为大图
        
        self.showBugPicture.hidden = NO;
        
    }else {
    
        self.showBugPicture.hidden = YES;
    }
    
    
}

//点击查看大图按钮
- (IBAction)clickBtn{
    
    WKLog(@"%s",__func__);
    
    WKShowPictureViewController *showVc = [[WKShowPictureViewController alloc]init];
    
    showVc.cards = self.cards;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVc animated:YES completion:nil];
    
}

@end
