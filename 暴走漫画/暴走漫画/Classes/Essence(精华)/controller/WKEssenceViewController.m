//
//  WKEssenceViewController.m
//  暴走漫画
//
//  Created by 阿拉斯加的狗 on 16/8/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKEssenceViewController.h"
#import "WKEssenceTagViewController.h"
#import "WKCardsViewController.h"
@interface WKEssenceViewController () <UIScrollViewDelegate>

//指示器的view
@property (nonatomic,strong)UIView *redView;
//选中点击的按钮
@property (nonatomic,strong)UIButton *selectedBtn;
//scollview
@property (nonatomic,strong)UIScrollView *contentView;
//获取titleView
@property (nonatomic,strong)UIView *titleView;

@end

@implementation WKEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WKGrobeColor;
    
    //设置导航条内容
    [self setUpItem];
    
    //初始化控制器
    [self setupChildVc];
    
    //创建头部标签
    [self setupTitleView];
    
    //创建scollview
    [self setupContenView];
    
}
//设置导航条内容
- (void)setUpItem {

    //设置导航条View
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置item
    self.navigationItem.leftBarButtonItem = [WKBarButtonItem itemWithImage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" action:@selector(clickBtn) target:self];

}

//初始化控制器
- (void)setupChildVc {
    
    WKCardsViewController *allVc = [[WKCardsViewController alloc]init];
    allVc.type = WKCardsTypeAllVc;
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    WKCardsViewController *videoVc = [[WKCardsViewController alloc]init];
    videoVc.type = WKCardsTypeVideo;
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    WKCardsViewController *voiceVc = [[WKCardsViewController alloc]init];
    allVc.type = WKCardsTypeVoice;
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    
    WKCardsViewController *pictureVc = [[WKCardsViewController alloc]init];
    pictureVc.type = WKCardsTypePicture;
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    WKCardsViewController *textVc = [[WKCardsViewController alloc]init];
    textVc.type = WKCardsTypeText;
    textVc.title = @"段子";
    [self addChildViewController:textVc];
    
}

- (void)clickBtn {

    WKEssenceTagViewController *tagVc = [[WKEssenceTagViewController alloc]init];
    [self.navigationController pushViewController:tagVc animated:YES];

}
//创建scollview
- (void)setupContenView {
    
    //取消自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加scorllview
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    //插入到titleview之上,最开始显示
    [self.view insertSubview:contentView atIndex:0];
    
    //设置scorllView的contsize
    NSInteger count = self.childViewControllers.count;
    contentView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * count, 0);
    
    self.contentView = contentView;
    
    //开始显示第一个控制器
    [self scrollViewDidEndScrollingAnimation:contentView];
}

//创建头部标签
- (void)setupTitleView {

    //创建头部标签
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    //设置frame
    CGFloat titleViewX = 0;
    CGFloat titleViewY = 64;
    CGFloat titleViewW = self.view.width;
    CGFloat titleViewH = 30;
    titleView.frame = CGRectMake(titleViewX, titleViewY, titleViewW, titleViewH);
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    //创建一个指示器View
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    redView.tag = -1;
    redView.height = 2;
    redView.y = titleView.height - redView.height;
    self.redView = redView;
    
    NSInteger count = self.childViewControllers.count;
    CGFloat buttonH = titleView.height;
    CGFloat buttonW = titleView.width / count;
    CGFloat buttonY = 0;
    //创建内部按钮标签
    
    for (NSInteger i = 0; i < count; i ++) {
        
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        [button setTitle:[self.childViewControllers[i] title] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        //按钮内文字居中
//        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        CGFloat buttonX = i * buttonW;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //添加按钮的点击
        [button addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        
//        WKLog(@"%@",NSStringFromCGRect(button.frame));
        
        //设置默认选中按钮
        if (i == 0) {
            //按钮内文字自动布局
            button.enabled = NO;
            self.selectedBtn = button;
            
            [button.titleLabel sizeToFit];
            self.redView.width = button.titleLabel.width;
            self.redView.centerX = button.centerX;
            
        }
    }
    
         [titleView addSubview:redView];
}

//点击的按钮
- (void)clickTitleBtn: (UIButton *)button {

    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    //设置指示器的位置
    [UIView animateWithDuration:0.25 animations:^{
        
        self.redView.width = button.titleLabel.width;
        self.redView.centerX = button.centerX;
    }];
    
    //获取scollview的偏移量
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    //获取当前点击索引
    NSInteger index = scrollView.contentOffset.x / self.view.width;
    UIViewController *vc = self.childViewControllers[index];
    
    //设置frame
    CGFloat vcViewX = scrollView.contentOffset.x;
    CGFloat vcViewH = scrollView.height;
    CGFloat vcViewY = 0;
    CGFloat vcViewW = scrollView.width;
    
    vc.view.frame = CGRectMake(vcViewX, vcViewY, vcViewW, vcViewH);
    
    [scrollView addSubview:vc.view];
    
}


//当停止拖拽时候调用

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //获取标签位置
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    [self clickTitleBtn:self.titleView.subviews[index]];
}

@end
