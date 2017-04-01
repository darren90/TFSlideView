//
//  NewsViewController.m
//  01_NOData
//
//  Created by Fengtf on 2017/3/31.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "NewsViewController.h"
#import "DGActivityIndicatorView.h"


@interface NewsViewController ()


@property (nonatomic,weak)DGActivityIndicatorView *activityView;


@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.view.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:237/255.0f green:85/255.0f blue:101/255.0f alpha:1.0f];

    UIColor *loadingColor = [UIColor colorWithRed:237/255.0f green:85/255.0f blue:101/255.0f alpha:1.0f];
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeRotatingTrigons tintColor:loadingColor];
    CGFloat width = self.view.bounds.size.width / 6.0f;
    CGFloat height = self.view.bounds.size.height / 6.0f;
    CGFloat x = (self.view.bounds.size.width - width) / 2.0;
    CGFloat y = (self.view.bounds.size.height - height) / 2.0;

    activityIndicatorView.frame = CGRectMake(x, y - 100, width, height);
    [self.view addSubview:activityIndicatorView];
    self.activityView = activityIndicatorView;
    [activityIndicatorView startAnimating];
    //    [activityIndicatorView]

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [activityIndicatorView stopAnimating];
    });
}









@end












