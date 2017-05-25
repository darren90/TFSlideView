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

#warning TODO -- 使用 autolayout 可以避免很多问题

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"--Demo--:%@",self.title);

    UILabel *label = [[UILabel alloc]init];
    self.contentLabel = label;
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    label.frame = CGRectMake(100, 100, 300, 300);
    label.center = self.view.center;
    label.textAlignment = NSTextAlignmentCenter;
    //    label.frame.size = CGSizeMake(300, 50);
    label.text = self.sTitle;

    NSLog(@"---self frame: %@",NSStringFromCGRect(self.view.frame));

}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    NSLog(@"---new self frame: %@",NSStringFromCGRect(self.view.frame));
}

- (void)setSTitle:(NSString *)sTitle{
    _sTitle = sTitle;
    
    self.contentLabel.text = sTitle;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"--Demo-:%@",NSStringFromCGRect(self.view.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
