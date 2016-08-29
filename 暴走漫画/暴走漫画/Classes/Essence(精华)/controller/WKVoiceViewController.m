//
//  WKVoiceViewController.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/28.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKVoiceViewController.h"

@interface WKVoiceViewController ()

@end

@implementation WKVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@----%zd----",[self class],indexPath.row];
    
    return cell;
}
@end
