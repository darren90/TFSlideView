//
//  ViewController.m
//  TFSlideView
//
//  Created by Fengtf on 2017/5/11.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "ViewController.h"
#import "TFSlideViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    TFSlideViewController *slide = [[TFSlideViewController alloc]init];
    slide.view.frame = self.view.bounds;
    [self.view addSubview:slide.view];
    [self addChildViewController:slide];
    slide.titles = @[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5",@"测试6",@"测试7",@"测试8",@"测试9",@"测试10",@"测试11",@"测试12",@"测试13",];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
