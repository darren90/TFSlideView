//
//  HomeViewController.m
//  Applications
//
//  Created by Fengtf on 2017/3/29.
//  Copyright © 2017年 DZN Labs. All rights reserved.
//

#import "HomeViewController.h"

#import "DGActivityIndicatorView.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:237/255.0f green:85/255.0f blue:101/255.0f alpha:1.0f];

    UIColor *loadingColor = [UIColor colorWithRed:237/255.0f green:85/255.0f blue:101/255.0f alpha:1.0f];
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeRotatingTrigons tintColor:loadingColor];
    CGFloat width = self.view.bounds.size.width / 6.0f;
    CGFloat height = self.view.bounds.size.height / 6.0f;
    CGFloat x = (self.view.bounds.size.width - width) / 2.0;
    CGFloat y = (self.view.bounds.size.height - height) / 2.0;

    activityIndicatorView.frame = CGRectMake(x, y, width, height);
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
//    [activityIndicatorView]
}



@end
