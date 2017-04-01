//
//  BaseViewController.m
//  01_NOData
//
//  Created by Fengtf on 2017/3/31.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "BaseViewController.h"
#import "DGActivityIndicatorView.h"

@interface BaseViewController ()

// Loading View
@property (nonatomic,weak)DGActivityIndicatorView * activityView;


@property (nonatomic,weak)UIImageView * nodataImgView;

@property (nonatomic,weak)UILabel * nodataTitleL;

@property (nonatomic,weak)UIButton * nodataBtn;


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];


//    [self initIndicatorView];
    [self initNoDataView];
}

-(void)initNoDataView{
    //1 - imageView
    self.nodataImgage = [UIImage imageNamed:@"placeholder_dropbox"];
    UIImageView * nodataImgView = [[UIImageView alloc]initWithImage:self.nodataImgage];
    self.nodataImgView = nodataImgView;
    nodataImgView.contentMode = UIViewContentModeScaleAspectFill;
    nodataImgView.clipsToBounds = YES;
    [self.view addSubview:nodataImgView];

    //2 - titlelabel
    UILabel * nodataTitleL = [[UILabel alloc]init];
    nodataTitleL.textColor = [UIColor colorWithRed:123/255.0 green:137/255.0 blue:148/255.0 alpha:1.0];
    nodataTitleL.textAlignment = NSTextAlignmentCenter;
    nodataTitleL.font = [UIFont systemFontOfSize:14.5];
    self.nodataTitleL = nodataTitleL;
    nodataTitleL.text = @"网络不好，请稍后重试";
    [self.view addSubview:nodataTitleL];

    //3 - nodataBtn
    UIButton * nodataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nodataBtn = nodataBtn;
    [nodataBtn addTarget:self action:@selector(nodataBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nodataBtn];

    //frame
    NSLayoutConstraint *t1 = [NSLayoutConstraint constraintWithItem:nodataTitleL attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *t2 = [NSLayoutConstraint constraintWithItem:nodataTitleL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:50.0];

    [self.view addConstraints:@[t1,t2]];

}

-(void)initIndicatorView{
    UIColor *loadingColor = [UIColor colorWithRed:237/255.0f green:85/255.0f blue:101/255.0f alpha:1.0f];
    DGActivityIndicatorView *activityView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeRotatingTrigons tintColor:loadingColor];

    CGFloat width = self.view.bounds.size.width / 6.0f;
    CGFloat height = self.view.bounds.size.height / 6.0f;
    CGFloat x = (self.view.bounds.size.width - width) / 2.0;
    CGFloat y = (self.view.bounds.size.height - height) / 2.0;

    activityView.frame = CGRectMake(x, y, width, height);
    [self.view addSubview:activityView];
    self.activityView = activityView;
    [activityView startAnimating];
}


//nodataBtn click
-(void)nodataBtnClick{
    self.nodataImgView.hidden = YES;
    self.nodataTitleL.hidden = YES;

    [self.activityView startAnimating];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
