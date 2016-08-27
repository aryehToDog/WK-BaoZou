//
//  WKFriendCategoryCell.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKFriendCategoryCell.h"
#import "WKFriendCategory.h"

@interface WKFriendCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation WKFriendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = WKGrobeColor;
    
    self.redView.backgroundColor = WKColor(250, 69, 65);
    
}


- (void)setCategory:(WKFriendCategory *)category {

    _category = category;
    
    //获取组名
    self.textLabel.text = category.name;

}

- (void)layoutSubviews {

    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
    
}


//从写选择中的属性
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    //设置选中隐藏指示View
    self.redView.hidden = !selected;
    
//    self.textLabel.textColor = WKGrobeColor;
//    self.textLabel.highlightedTextColor = WKColor(250, 69, 65);
    self.textLabel.textColor = selected ? WKColor(250, 69, 65) : WKColor(78, 78, 78);
    
}

@end
