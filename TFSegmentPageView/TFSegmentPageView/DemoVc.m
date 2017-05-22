//
//  DemoVc.m
//  TFSegmentPageView
//
//  Created by Tengfei on 2017/5/22.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "DemoVc.h"

@interface DemoVc ()

@end

@implementation DemoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"--Demo--:%@",self.title);
    
    
    UILabel *label = [[UILabel alloc]init];
//    self.contentLabel = label;
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    label.frame = CGRectMake(100, 100, 300, 300);
    label.center = self.view.center;
    label.textAlignment = NSTextAlignmentCenter;
    //    label.frame.size = CGSizeMake(300, 50);
}

- (void)setSTitle:(NSString *)sTitle{
    _sTitle = sTitle;
    
    self.contentLabel.text = sTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
