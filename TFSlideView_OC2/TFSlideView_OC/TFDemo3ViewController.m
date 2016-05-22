//
//  TFDemo3ViewController.m
//  TFSlideView_OC
//
//  Created by Fengtf on 16/5/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//


#import "TFDemo3ViewController.h"
#import "PageNViewController.h"
#import "TFMultiSlideView.h"
#import "TFSlideView.h"
#import "TFLRUCache.h"

#import "PageNViewController.h"

#define KRandomColor     [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];

@interface TFDemo3ViewController ()<TFMultiSlideViewDelegate>
@property (weak, nonatomic) TFMultiSlideView *slideView;

@end

@implementation TFDemo3ViewController
{
    NSMutableArray *itemArray_;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    TFMultiSlideView *slideView = [[TFMultiSlideView alloc]init];
    [self.view addSubview:slideView];
    slideView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    slideView.delegate = self;
//    self.slideView = slideView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;// 如果你使用了UITabBarController, 系统会自动调整scrollView的inset。加上这个如果出错的话。
    
    // Do any additional setup after loading the view from its nib.
    TFLRUCache *cache = [[TFLRUCache alloc] initWithCount:11];
    
    TFScrollTabbarView *tabbar = [[TFScrollTabbarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 34)];
    tabbar.tabItemNormalColor = [UIColor blackColor];
    tabbar.tabItemSelectedColor = [UIColor redColor];
    tabbar.tabItemNormalFontSize = 14.0f;
    tabbar.trackColor = [UIColor redColor];
    
    
    NSArray *arr = [NSArray arrayWithObjects:@"综合",@"美",@"剧",@"神盾局",@"",@"人人神盾", nil];
    ;
    
    itemArray_ = [NSMutableArray array];
    TFScrollTabbarItem *item = [TFScrollTabbarItem itemWithTitle:@"推荐" width:60];
    [itemArray_ addObject:item];
    for (int i=0; i<10; i++) {
        item = [TFScrollTabbarItem itemWithTitle:[NSString stringWithFormat:@"页面%d%@", i+1,arr[arc4random_uniform(5)]] width:60];
        [itemArray_ addObject:item];
    }
    tabbar.tabbarItems = itemArray_;
    
    slideView.tabbar = tabbar;
    slideView.cache = cache;
    slideView.tabbarBottomSpacing = 5;
    slideView.baseViewController = self;
    [slideView setup];
    slideView.selectedIndex = 0;
}

-(NSInteger)numberOfTabsInTFMultiSlideView:(TFMultiSlideView *)sender{
    return itemArray_.count;
}

-(UIViewController *)TFMultiSlideView:(TFMultiSlideView *)sender controllerAt:(NSInteger)index{
    PageNViewController *ctrl = [[PageNViewController alloc] init];
    int32_t rgbValue = rand();
    ctrl.view.backgroundColor = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
    ctrl.pageLabel.text = [NSString stringWithFormat:@"%ld", (long)index];
    return ctrl;
}
@end
