//
//  DLDemoViewController.m
//  TFSlideView_OC
//
//  Created by Fengtf on 16/4/7.
//  Copyright © 2016年 tengfei. All rights reserved.
//
// 2.获得RGB颜色
#define MJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define KRandomColor     [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];


#import "DLDemoViewController.h"
#import "DLTabedSlideView.h"

@interface DLDemoViewController ()<DLTabedSlideViewDelegate>
@property (weak, nonatomic) DLTabedSlideView *tabedSlideView;

@end

@implementation DLDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSlideView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


-(void)initSlideView
{
    DLTabedSlideView *tabedSlideView = [[DLTabedSlideView alloc]init];
    [self.view addSubview:tabedSlideView];
    tabedSlideView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    self.tabedSlideView = tabedSlideView;
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.delegate = self;
    self.tabedSlideView.tabItemNormalColor = MJColor(68, 68, 68);
    self.tabedSlideView.tabItemSelectedColor = MJColor(52, 174, 255);
    self.tabedSlideView.tabbarTrackColor = MJColor(52, 174, 255);
    self.tabedSlideView.titleFont = [UIFont systemFontOfSize:17];
    self.tabedSlideView.tabbarBottomSpacing = 0.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"综合"];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"美剧"];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"视频"];
    DLTabedbarItem *item4 = [DLTabedbarItem itemWithTitle:@"UP主"];
    self.tabedSlideView.tabbarItems = @[item1, item2, item3,item4];
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex = 0;
    //    tabedSlideView.backgroundColor = [UIColor blueColor];
    
    //    [self addLaebl];
}

//-(void)addLaebl{
//    for (UIView *view  in self.tabedSlideView.slideView_) {
//        NSLog(@"%@",view);
//        if ([view isKindOfClass:[UILabel class]]) {
//            UILabel *label = (UILabel *)view;
//            NSLog(@"%@",label.text);
//        }
//    }
//}

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 4;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0: {
            UIViewController *ctrl = [[UIViewController alloc] init];
            ctrl.view.backgroundColor = KRandomColor;
            //            ctrl.selectedIndex = index;
            //            ctrl.sortStr = self.topTitle;
            return ctrl;
        }
        case 1:  {
            UIViewController *ctrl = [[UIViewController alloc] init];
            ctrl.view.backgroundColor = KRandomColor;
            //            ctrl.selectedIndex = index;
            //            ctrl.sortStr = self.topTitle;
            return ctrl;
        }
        case 2:  {
            UIViewController *ctrl = [[UIViewController alloc] init];
            ctrl.view.backgroundColor = KRandomColor;
            //            ctrl.selectedIndex = index;
            //            ctrl.sortStr = self.topTitle;
            return ctrl;
        }
        case 3:  {
            UIViewController *ctrl = [[UIViewController alloc] init];
            ctrl.view.backgroundColor = KRandomColor;
            //            ctrl.selectedIndex = index;
            //            ctrl.sortStr = self.topTitle;
            return ctrl;
        }
        default:
            return nil;
    }
}

@end
