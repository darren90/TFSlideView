//
//  Demo1ViewController.m
//  TFSlideView
//
//  Created by Fengtf on 2017/5/15.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "Demo1ViewController.h"

@interface Demo1ViewController ()

@end

@implementation Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UILabel *label = [[UILabel alloc]init];
    self.contentLabel = label;
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    label.frame = CGRectMake(100, 100, 300, 300);
    label.center = self.view.center;
    label.textAlignment = NSTextAlignmentCenter;
 //    label.frame.size = CGSizeMake(300, 50);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
