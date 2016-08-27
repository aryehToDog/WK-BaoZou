//
//  WKFriendUserCell.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKFriendUserCell.h"
#import <UIImageView+WebCache.h>
#import "WKFriendUser.h"

@interface WKFriendUserCell ()
/* 粉丝 */
@property (weak, nonatomic) IBOutlet UILabel *fansLable;
/* 姓名 */
@property (weak, nonatomic) IBOutlet UILabel *screenLable;
/* 图像 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@end

@implementation WKFriendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//从写内部方法
- (void)setUesr:(WKFriendUser *)uesr {

    _uesr = uesr;

    //设置图像
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:uesr.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    //设置名字
    self.screenLable.text = uesr.screen_name;
    
    //设置粉丝数
    NSString *fans = nil;
    if (uesr.fans_count < 10000) {
        
        fans = [NSString stringWithFormat:@"%zd人关注",uesr.fans_count];
    } else {
 
        fans = [NSString stringWithFormat:@"%.1f万人关注",uesr.fans_count / 10000.0];
    }
    
    self.fansLable.text = fans;

}

@end
