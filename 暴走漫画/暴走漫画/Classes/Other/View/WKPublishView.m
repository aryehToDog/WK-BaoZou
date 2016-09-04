//
//  WKPublishView.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/9/3.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKPublishView.h"
#import "WKloginReguistBtn.h"
#import <POP.h>
#define WKspringFact 5
#define WKAnimationDelay 0.1
@implementation WKPublishView


+ (instancetype)publishView {

    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];


}

static UIWindow *window_;

+ (void)show {

    window_ = [[UIWindow alloc]init];
    
    window_.frame = [UIScreen mainScreen].bounds;
    
    window_.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    
    //显示窗口
    window_.hidden = NO;
    WKPublishView *publishView = [WKPublishView publishView];
    publishView.frame = window_.frame;
    [window_ addSubview:publishView];
    
    
}

- (void)awakeFromNib {

    //取消与用户交互
    self.userInteractionEnabled = NO;
    
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //添加按钮
    CGFloat btnW = 72;
    CGFloat btnH = btnW + 30;
    CGFloat startX = 20;
    CGFloat startY = (WKScreenH - 2 * btnH) * 0.5;
    int colCount = 3;
    CGFloat maraginX = (WKScreenW - 2 * startX - colCount * btnW) / (colCount - 1);
    
    for (int i = 0; i < images.count ; i ++ ) {
        
        WKloginReguistBtn *btn = [[WKloginReguistBtn alloc]init];
        
        //行号
        int row = i / colCount;
        
        //列号
        int col = i % colCount;
        
        CGFloat btnX = startX + col * (btnW + maraginX);
        CGFloat btnY = startY + row * btnH;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        CGRect startF = CGRectMake(btnX, btnY - WKScreenH, btnW, btnH);
        
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i;
        [self addSubview:btn];
        
        //添加按钮点击事件
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //添加pop动画
        POPSpringAnimation *ani = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        ani.fromValue = [NSValue valueWithCGRect:startF];
        ani.toValue = [NSValue valueWithCGRect:btn.frame];
        //设置动画弹性时长
        ani.springSpeed = WKspringFact;
        ani.springBounciness = WKspringFact;
        ani.beginTime = CACurrentMediaTime() + WKAnimationDelay * i;
        
        [ani setCompletionBlock:^(POPAnimation *anition, BOOL finishion) {
            //用户交互
            self.userInteractionEnabled = YES;
        }];
        
        [btn pop_addAnimation:ani forKey:nil];

        
    }
    //创建标题imageview
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    imageView.centerX = WKScreenW * 0.5;
    CGFloat imageEndY = WKScreenH * 0.2;
    CGFloat imageStartY = imageEndY - WKScreenH;
    //添加pop动画
    POPSpringAnimation *ani = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    ani.fromValue = [NSValue valueWithCGPoint:CGPointMake(imageView.centerX, imageStartY)];
    ani.toValue = [NSValue valueWithCGPoint:CGPointMake(imageView.centerX, imageEndY)];
    //设置动画弹性时长
    ani.springSpeed = WKspringFact;
    ani.springBounciness = WKspringFact;
    ani.beginTime = CACurrentMediaTime() + WKAnimationDelay * titles.count;
    [imageView pop_addAnimation:ani forKey:nil];
    [self addSubview:imageView];


}

- (void)clickBtn: (UIButton *)btn {

    [self cancleWithCompletionBlock:^{
        if (btn.tag == 0) {
            
            WKLog(@"点击视频");
        }else if (btn.tag == 1){
            
            WKLog(@"点击图片");
        }
        
        
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self cancleWithCompletionBlock:nil];

}

- (IBAction)cancle {
 
    [self cancleWithCompletionBlock:nil];
}


//先执行动画,动画完成后在执行操作
- (void)cancleWithCompletionBlock:(void(^)())Completionblock{

    self.userInteractionEnabled = YES;
    
    int beginIndex = 1;
    
    for (int i = beginIndex; i < self.subviews.count; i ++) {
        
        UIView *views = self.subviews[i];
        
        //添加pop动画
        POPBasicAnimation *ani = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
        ani.fromValue = [NSValue valueWithCGRect:views.frame];
        ani.toValue = [NSValue valueWithCGRect:CGRectMake(views.x, views.y + WKScreenH, views.width, views.height)];

        ani.beginTime = CACurrentMediaTime() + WKAnimationDelay * i;
        [views pop_addAnimation:ani forKey:nil];
        
        if (i == self.subviews.count - 1) {
            
            [ani setCompletionBlock:^(POPAnimation *ani, BOOL finished) {
               
                //销毁窗口
                window_ = nil;
                [self removeFromSuperview];
                !Completionblock ? : Completionblock();
                
            }];
            
        }
        
        
    }
    

}

@end
