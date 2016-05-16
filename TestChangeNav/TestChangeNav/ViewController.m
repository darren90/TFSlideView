//
//  ViewController.m
//  TestChangeNav
//
//  Created by Fengtf on 15/11/25.
//  Copyright © 2015年 ftf. All rights reserved.
//

#import "ViewController.h"
#import "RKSwipeBetweenViewControllers.h"
#import "Tweet_RootViewController.h"
#import "OneController.h"
#import "TwoController.h"
#import "ThreeController.h"

@interface ViewController ()

@property (nonatomic,strong)  RKSwipeBetweenViewControllers *nav_tweet ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    RKSwipeBetweenViewControllers *nav_tweet = [RKSwipeBetweenViewControllers newSwipeBetweenViewControllers];
    OneController *oneVc = [[OneController alloc]init];
    TwoController *twoVc = [[TwoController alloc]init];
    ThreeController *threeVc = [[ThreeController alloc]init];
    [nav_tweet.viewControllerArray addObjectsFromArray:@[oneVc,
                                                         twoVc,
                                                         threeVc]];
     nav_tweet.buttonText = @[@"冒泡广场", @"朋友圈", @"热门冒泡"];
    self.nav_tweet = nav_tweet;
    [self.view addSubview:nav_tweet.view];
    nav_tweet.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
//    nav_tweet.buttonText
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
