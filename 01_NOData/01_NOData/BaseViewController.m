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

@property (nonatomic,weak)UIScrollView * bgScrollView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initScrollView];
    [self initNoDataView];
    [self initIndicatorView];

    //默认开始请求
    [self nodataBtnClick];
}

-(void)initScrollView{
    UIScrollView * bgScrollView = [[UIScrollView alloc]init];
    self.bgScrollView = bgScrollView;
    [self.view addSubview:bgScrollView];
    bgScrollView.alwaysBounceVertical = YES;
    bgScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *s1 = [NSLayoutConstraint constraintWithItem:bgScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *s2 = [NSLayoutConstraint constraintWithItem:bgScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *s3 = [NSLayoutConstraint constraintWithItem:bgScrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *s4 = [NSLayoutConstraint constraintWithItem:bgScrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraints:@[s1,s2,s3,s4]];
}


-(void)initNoDataView{
    //1 - imageView
    self.nodataImgage = [UIImage imageNamed:@"placeholder_round"];
    UIImageView * nodataImgView = [[UIImageView alloc]initWithImage:self.nodataImgage];
    self.nodataImgView = nodataImgView;
    nodataImgView.contentMode = UIViewContentModeScaleAspectFill;
    nodataImgView.clipsToBounds = YES;
    [self.bgScrollView addSubview:nodataImgView];

    //2 - titlelabel
    UILabel * nodataTitleL = [[UILabel alloc]init];
    nodataTitleL.textColor = [UIColor colorWithRed:123/255.0 green:137/255.0 blue:148/255.0 alpha:1.0];
    nodataTitleL.textAlignment = NSTextAlignmentCenter;
    nodataTitleL.font = [UIFont systemFontOfSize:14.5];
    self.nodataTitleL = nodataTitleL;
    nodataTitleL.text = @"网络不好，请稍后重试";
    [self.bgScrollView addSubview:nodataTitleL];

    //3 - nodataBtn
    UIButton * nodataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nodataBtn = nodataBtn;
    [nodataBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    nodataBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [nodataBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:126/255.0 blue:229/255.0 alpha:1.0] forState:UIControlStateNormal];
    [nodataBtn setTitleColor:[UIColor colorWithRed:72/255.0 green:161/255.0 blue:234/255.0 alpha:1.0] forState:UIControlStateHighlighted];

    [nodataBtn addTarget:self action:@selector(nodataBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollView addSubview:nodataBtn];


    nodataImgView.translatesAutoresizingMaskIntoConstraints = NO;

    nodataTitleL.translatesAutoresizingMaskIntoConstraints = NO;

    nodataBtn.translatesAutoresizingMaskIntoConstraints = NO;


    // 1 - title frame
    NSLayoutConstraint *t1 = [NSLayoutConstraint constraintWithItem:nodataTitleL attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.bgScrollView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *t2 = [NSLayoutConstraint constraintWithItem:nodataTitleL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bgScrollView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];

    [self.view addConstraints:@[t1,t2]];

    // 2 - image frame
    NSLayoutConstraint *m1 = [NSLayoutConstraint constraintWithItem:nodataImgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.nodataTitleL attribute:NSLayoutAttributeTop multiplier:1.0 constant:-20.0];
    NSLayoutConstraint *m2 = [NSLayoutConstraint constraintWithItem:nodataImgView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.bgScrollView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];

    [self.bgScrollView addConstraints:@[m1,m2]];

    // 3 - btn frame
    NSLayoutConstraint *b1 = [NSLayoutConstraint constraintWithItem:nodataBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nodataTitleL attribute:NSLayoutAttributeBottom multiplier:1.0 constant:7.0];
    NSLayoutConstraint *b2 = [NSLayoutConstraint constraintWithItem:nodataBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.bgScrollView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];

    [self.view addConstraints:@[b1,b2]];

}

-(void)initIndicatorView{
    UIColor *loadingColor = [UIColor colorWithRed:0/255.0 green:126/255.0 blue:229/255.0 alpha:1.0];//[UIColor colorWithRed:237/255.0f green:85/255.0f blue:101/255.0f alpha:1.0f];
    DGActivityIndicatorView *activityView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeRotatingTrigons tintColor:loadingColor];

    activityView.translatesAutoresizingMaskIntoConstraints = NO;

    CGFloat lw = self.view.bounds.size.width / 6.0f;
    CGFloat lh = self.view.bounds.size.height / 6.0f;
    
//    activityView.backgroundColor = [UIColor blueColor];

    [self.bgScrollView addSubview:activityView];
    self.activityView = activityView;
//    [activityView startAnimating];
 
    CGFloat x = (self.view.bounds.size.width - lw) / 2.0;
    CGFloat y = (self.view.bounds.size.height - lh) / 2.0;
    activityView.frame = CGRectMake(x, y - 130, lw, lh);

//    NSLayoutConstraint *l1 = [NSLayoutConstraint constraintWithItem:activityView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
//    NSLayoutConstraint *l2 = [NSLayoutConstraint constraintWithItem:activityView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
//
//    NSLayoutConstraint *w = [NSLayoutConstraint constraintWithItem:activityView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:lw];
//    NSLayoutConstraint *h = [NSLayoutConstraint constraintWithItem:activityView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:lh];
//
//    [activityView addConstraints:@[w,h]];
//    [self.view addConstraints:@[l1,l2]];
}


-(void)nodataBtnClick{
    [self startAnimate];

    [self request];
    NSLog(@"frame:%@-%@",NSStringFromCGRect(self.view.frame),NSStringFromCGRect(self.activityView.frame));
}

//nodataBtn click
-(void)request{
    NSLog(@"----base---");

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self stopAnimateAndShowError:nil];
//    });

}




-(void)startAnimate{
//    [UIView animateWithDuration:0.5 animations:^{
        self.nodataImgView.hidden = YES;
        self.nodataTitleL.hidden = YES;
        self.nodataBtn.hidden = YES;

//    }];

    [self.activityView startAnimating];
}

-(void)stopAnimate{
    [self.activityView stopAnimating];
//    [UIView animateWithDuration:0.5 animations:^{
    self.nodataImgView.hidden = YES;
    self.nodataTitleL.hidden = YES;
    self.nodataBtn.hidden = YES;
    self.bgScrollView.hidden = YES;
    
    [self.nodataImgView removeFromSuperview];
    [self.nodataTitleL removeFromSuperview];
    [self.nodataBtn removeFromSuperview];
    [self.bgScrollView removeFromSuperview];
    
//    }];
}

-(void)stopAnimateAndShowError:(NSString *)msg{
    [self.view bringSubviewToFront:self.bgScrollView];
    
    if (msg) {
        self.nodataTitleL.text = msg;
    }

    [self.activityView stopAnimating];
    self.nodataImgView.hidden = NO;
    self.nodataTitleL.hidden = NO;
    self.nodataBtn.hidden = NO;
}


#pragma mark ---- 业务逻辑

-(void)setRequestState:(RequestState)requestState{
    _requestState = requestState;

    switch (requestState) {
        case RequestStateNone:
        {
            [self stopAnimate];
            
        }
            break;
        case RequestStateNoNet:
        {
            [self stopAnimateAndShowError:nil];
        }
            
            break;
        case RequestStateNoData:
        {
            [self stopAnimateAndShowError:@"暂无数据,请稍后重试"];
        }
            break;
            
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
