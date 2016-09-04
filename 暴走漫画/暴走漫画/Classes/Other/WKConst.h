//
//  WKConst.h
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/30.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    WKCardsTypeAllVc = 1,
    WKCardsTypeVideo = 41,
    WKCardsTypeVoice = 31,
    WKCardsTypePicture = 10,
    WKCardsTypeText = 29
    
}WKCardsType;

/** 精华顶部View的H */
UIKIT_EXTERN CGFloat const WKTitilesViewH;
/** 精华顶部View的Y */
UIKIT_EXTERN CGFloat const WKTitilesViewY;

/** 精华图片头像最大Y值 */
UIKIT_EXTERN CGFloat const WKCardPictureY;
/** 精华图片头像间距 */
UIKIT_EXTERN CGFloat const WKCardPictureMaragin;
/** 精华图片底部View的高度 */
UIKIT_EXTERN CGFloat const WKCardBottonH;
/** 精华图片大图最大高度 */
UIKIT_EXTERN CGFloat const WKCardPictureMaxH;
/** 精华图片大图最大高度外的的高度 */
UIKIT_EXTERN CGFloat const WKCardPictureClicpH;
