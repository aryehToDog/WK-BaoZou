//
//  WKShowPictureViewController.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/9/1.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKShowPictureViewController.h"
#import "WKProgressView.h"
#import "WKCards.h"
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
@interface WKShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scorllView;
@property (weak, nonatomic) IBOutlet WKProgressView *progressView;
@property (nonatomic,strong)UIImageView *pictureImageView;
@end

@implementation WKShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *pictureImageView = [[UIImageView alloc]init];
    
    pictureImageView.userInteractionEnabled = YES;
    
    //添加一个点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backBtn)];
    
    [pictureImageView addGestureRecognizer:tap];
    
    [self.scorllView addSubview:pictureImageView];
  
    self.pictureImageView = pictureImageView;

    //设置图片尺寸
    CGFloat imageW = WKScreenW;
    
    CGFloat scale = self.cards.width ? self.cards.height / self.cards.width : 1.0f;
    
    CGFloat imageH = imageW * scale;
    
    if (imageH > WKScreenH) {
        
        pictureImageView.frame = CGRectMake(0, 0, imageW, imageH);
        self.scorllView.contentSize = CGSizeMake(0, imageH);
    }else {
        
        pictureImageView.size = CGSizeMake(imageW, imageH);
        pictureImageView.centerY = WKScreenH * 0.5;
    }
    
    
    //刷新纪录上一次保存的进度
    [self.progressView setProgress:self.cards.progress animated:YES];
    
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:self.cards.middle_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.cards.progress = 1.0 * receivedSize / expectedSize;
        //显示进度
        [self.progressView setProgress:self.cards.progress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        
        
    }];
    

}



/**
 *  返回按钮
 */
- (IBAction)backBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/**
 *  保存
 */
- (IBAction)saveBtn {
    
    //图片没下载完不允许下载
    if (self.pictureImageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
        return;
    }
    
    UIImageWriteToSavedPhotosAlbum(self.pictureImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    }else {
    
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }

}

/**
 *  转发
 */
- (IBAction)receiveBtn {
    
    WKLog(@"%s",__func__);
    
}



@end
