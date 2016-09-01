//
//  WKCards.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/30.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKCards.h"
#import <MJExtension.h>
@implementation WKCards
{
    CGFloat _cellHeight;
    CGRect _pictureF;
    
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{
             @"small_image": @"image0",
             @"middle_image": @"image2",
             @"large_image": @"image1"
             };

}

- (NSString *)create_time {

    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }



}

//返回的行高
- (CGFloat)cellHeight {

    if (!_cellHeight) {
        //计算文字的高度
        CGSize textSize = CGSizeMake(WKScreenW - 4 * WKCardPictureMaragin, CGFLOAT_MAX);
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
        
        //获取文字的高度
        CGFloat textH = [self.text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        
        _cellHeight = WKCardPictureY + textH + WKCardPictureMaragin;
        
        //当是在图片模块
        if (self.type == WKCardsTypePicture) {
            
            //计算图片的frame
            CGFloat pictureW = textSize.width;
            //  pictureW   self.width
            //  pictureH   self.height
            CGFloat pictureH = pictureW * self.height / self.width;
            
            if (pictureH >= WKCardPictureMaxH) {     //为大图
                
                self.bigPicture = YES;
                pictureH = WKCardPictureClicpH;
                
            }
            CGFloat  pictureX = WKCardPictureMaragin;
            CGFloat  pictureY = WKCardPictureY + textH + WKCardPictureMaragin ;
            
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
         
            
            _cellHeight += pictureH + WKCardPictureMaragin;
        }
        
        _cellHeight += WKCardPictureMaragin + WKCardBottonH;
    }
    

    
    return _cellHeight;

}

@end
