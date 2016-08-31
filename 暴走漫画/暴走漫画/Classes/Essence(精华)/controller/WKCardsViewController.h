//
//  WKCardsViewController.h
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/30.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WKCardsViewController : UITableViewController

/** 定义一个属性用来标记不同页面显示的段子内容 */
@property (nonatomic,assign)WKCardsType type;

@end
