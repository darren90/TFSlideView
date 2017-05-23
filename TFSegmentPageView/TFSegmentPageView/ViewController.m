//
//  ViewController.m
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/22.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "ViewController.h"
#import "TFSegmentPageView.h"
#import "DemoVc.h"


#define KRandomColor     [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];


@interface ViewController ()<TFScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;

@property (nonatomic,weak) TFSegmentPageView *pageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.titles = @[@"新闻头条",
                    @"国际要闻",
                    @"体育",
                    @"中国足球",
                    @"汽车",
                    @"囧途旅游",
                    @"幽默搞笑",
                    @"视频",
                    @"无厘头",
                    @"美女图片",
                    @"今日房价",
                    @"头像",  ];

    CGRect sfame = CGRectMake(0, 20,self.view.bounds.size.width, self.view.bounds.size.height - 20);
    TFSegmentPageView *pageView = [[TFSegmentPageView alloc]initWithFrame:sfame config:nil titles:self.titles parentViewController:self delegate:self];
    [self.view addSubview:pageView];
    self.pageView = pageView;
}


- (NSInteger)numberOfItemsInPageView:(TFSegmentPageView *)pageView{
    return self.titles.count;
}

- (UIViewController *)pageView:(TFSegmentPageView *)pageView vcForRowAtIndex:(NSInteger)index{
    DemoVc *vc = [[DemoVc alloc]init];
    NSString *title = [NSString stringWithFormat:@"--:%@-%ld",self.titles[index],(long)index];
    vc.title = title;
    vc.view.backgroundColor = KRandomColor;
    vc.sTitle = title;
    return vc;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // https://github.com/jasnig/ZJScrollPageView
}


@end
