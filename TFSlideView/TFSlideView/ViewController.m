//
//  ViewController.m
//  TFSlideView
//
//  Created by Fengtf on 2017/5/11.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "ViewController.h"
#import "TFSlideViewController.h"
#import "Demo1ViewController.h"

@interface ViewController ()<TFSlideViewControllerDelegate>

@end
//这个 Segmented Control 是热词

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    TFSlideViewController *slide = [[TFSlideViewController alloc]init];
    slide.view.frame = self.view.bounds;
    [self.view addSubview:slide.view];
    [self addChildViewController:slide];
    slide.deledate = self;
//    slide.titles = @[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5",@"测试6",@"测试7",@"测试8",@"测试9",@"测试10",@"测试11",@"测试12",@"测试13",];
    slide.titles = @[@"Hi!推荐0",@"聊美剧1",@"听音乐2",@"看世界3",@"测试"];

}

-(UIViewController *)TFSlideViewController:(TFSlideViewController *)sendVc didSelectAtIndex:(NSInteger)index{

    Demo1ViewController *vc = [[Demo1ViewController alloc]init];
    vc.title = [NSString stringWithFormat:@"测试 - Title : %ld",(long)index];
    vc.view.backgroundColor = [UIColor cyanColor];
    vc.contentLabel.text = [NSString stringWithFormat:@"测试 - Title : %ld",(long)index];
    return vc;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
