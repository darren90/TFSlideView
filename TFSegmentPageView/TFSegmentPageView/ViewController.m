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
    
    self.titles = @[@"精选",
                    @"音乐",
                    @"时尚",
                    @"综艺",
                    @"娱乐",
                    @"体育",
                    @"美剧",
                    @"电视剧",
 ];

    TFSegmentStyleConfig *config = [TFSegmentStyleConfig config];
    config.extraEdgeright = 40;
    config.selectedTitleColor = [UIColor blackColor];

    CGRect sfame = CGRectMake(0, 20,self.view.bounds.size.width, self.view.bounds.size.height - 20);
    TFSegmentPageView *pageView = [[TFSegmentPageView alloc]initWithFrame:sfame config:config titles:self.titles parentViewController:self delegate:self];
    [self.view addSubview:pageView];
    self.pageView = pageView;


    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pageView.topView addSubview:btn];
    [btn setTitle:@"切换" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor cyanColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    btn.frame = CGRectMake(self.view.frame.size.width-30, 10, 40, 30);
    [btn addTarget:self action:@selector(relodItem) forControlEvents:UIControlEventTouchUpInside];

    NSLog(@"-doubleExtraScreen-:%d",self.pageView.topView.doubleExtraScreen);
}

- (void)relodItem{
    self.titles = [self setupNewTitles];
    // 传入新的titles同时reload
    [self.pageView reloadNewTitles:self.titles];

    NSLog(@"-doubleExtraScreen-:%d",self.pageView.topView.doubleExtraScreen);
}

- (NSArray *)setupNewTitles {

    NSMutableArray *tempt = [NSMutableArray array];
    for (int  i =0; i < 20; i++) {
        [tempt addObject:[NSString stringWithFormat:@"新标题%d",i]];
    }

    return tempt;
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
