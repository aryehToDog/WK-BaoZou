//
//  WKEssenceTageCell.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/28.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKEssenceTageCell.h"
#import <UIImageView+WebCache.h>
#import "WKEssenceTage.h"
@interface WKEssenceTageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *screenLable;
@property (weak, nonatomic) IBOutlet UILabel *fansLable;


@end

@implementation WKEssenceTageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setTage:(WKEssenceTage *)tage {

    [self.headerView sd_setImageWithURL:[NSURL URLWithString:tage.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.screenLable.text = tage.screen_name;
    
    NSString *fans = nil;
    if (tage.fans_count < 10000) {
       
        fans = [NSString stringWithFormat:@"%zd人订阅",tage.fans_count];
    }else {
    
        fans = [NSString stringWithFormat:@"%.1ld万人订购",tage.fans_count / 10000];
    }

    self.fansLable.text = fans;
}

//设置frame的距离
- (void)setFrame:(CGRect)frame {

    frame.origin.x = 5;
    frame.size.width = frame.size.width - 2 * frame.origin.x;
    frame.size.height = frame.size.height - 1;
    [super setFrame:frame];
}

@end
