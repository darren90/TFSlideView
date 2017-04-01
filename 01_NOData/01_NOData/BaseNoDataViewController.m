//
//  NoDataViewController.m
//  Applications
//
//  Created by Fengtf on 2017/3/28.
//  Copyright © 2017年 DZN Labs. All rights reserved.
//

#import "BaseNoDataViewController.h"
#import "UIColor+Hexadecimal.h"

#import "UIScrollView+EmptyDataSet.h"

#import "MJRefresh/MJRefresh.h"

@interface BaseNoDataViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>


//@property (nonatomic, assign,getter = isLoading) BOOL loading;
@end

@implementation BaseNoDataViewController

-(instancetype)init{
    if (self = [super init]) {

    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.page = 1;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;

    [self configureHeaderAndFooter];

//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerAction)];
//    [self.tableView.mj_header beginRefreshing];


//    [self reTryeAction];
}

-(void)headerAction{
//    NSLog(@"-----");
    [self reTryeAction];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self configureNavigationBar];
}


#pragma mark - Configuration and Event Methods

- (void)configureNavigationBar
{
    UIColor *barColor = nil;
    UIColor *tintColor = nil;
    UIStatusBarStyle barstyle = UIStatusBarStyleDefault;

    self.navigationController.navigationBar.titleTextAttributes = nil;

    barColor = [UIColor whiteColor];
    tintColor = [UIColor colorWithHex:@"007ee5"];

    self.navigationController.navigationBar.barTintColor = barColor;
    self.navigationController.navigationBar.tintColor = tintColor;

    [[UIApplication sharedApplication] setStatusBarStyle:barstyle animated:YES];
}

- (void)configureHeaderAndFooter
{

    self.tableView.tableHeaderView = [UIView new];

    self.tableView.tableFooterView = [UIView new];
}

- (void)didTapHeaderView:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)setLoading:(BOOL)loading
{
    if (_loading == loading) {
        return;
    }

    _loading = loading;

    [self.tableView reloadEmptyDataSet];
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    return cell;
}


#pragma mark - DZNEmptyDataSetSource Methods

//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSString *text = nil;
//    UIFont *font = nil;
//    UIColor *textColor = nil;
//
//    NSMutableDictionary *attributes = [NSMutableDictionary new];
//
//    text = @"Star Your Favorite Files";
//    font = [UIFont boldSystemFontOfSize:17.0];
//    textColor = [UIColor colorWithHex:@"25282b"];
//
//    if (!text) {
//        return nil;
//    }
//
//    if (font) [attributes setObject:font forKey:NSFontAttributeName];
//    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
//
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.loading) {
        return nil;
    }
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;

    NSMutableDictionary *attributes = [NSMutableDictionary new];

    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;

    text = @"网络不好，请稍后重试";
    font = [UIFont systemFontOfSize:14.5];
    textColor = [UIColor colorWithHex:@"7b8994"];

    if (!text) {
        return nil;
    }

    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];

    return attributedString;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.loading) {
        return [UIImage imageNamed:@"loading_imgBlue_78x78"]; //loading img
    }
    else {
//        NSString *imageName = [[[NSString stringWithFormat:@"placeholder_%@", self.application.displayName] lowercaseString]
//                               stringByReplacingOccurrencesOfString:@" " withString:@"_"];
//        imageName = @"no-wifi"; //no-wifi
        NSString *imageName = @"placeholder_dropbox";
        return [UIImage imageNamed:imageName];
    }
}


- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;

    return animation;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    if (self.loading) {
        return nil;
    }
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;

    text = @"重新加载";
    font = [UIFont systemFontOfSize:15.0];
    textColor = [UIColor colorWithHex:(state == UIControlStateNormal) ? @"007ee5" : @"48a1ea"];

    if (!text) {
        return nil;
    }

    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
//{
//    NSString *imageName = [[NSString stringWithFormat:@"button_background_%@", self.application.displayName] lowercaseString];
//
//    if (state == UIControlStateNormal) imageName = [imageName stringByAppendingString:@"_normal"];
//    if (state == UIControlStateHighlighted) imageName = [imageName stringByAppendingString:@"_highlight"];
//
//    NSLog(@"--buttonBackgroundImageForEmptyDataSet-:%@",imageName);
//    UIEdgeInsets capInsets = UIEdgeInsetsMake(-10.0, 10.0, 10.0, 10.0);
//    UIEdgeInsets rectInsets = UIEdgeInsetsZero;
//
//    return [[[UIImage imageNamed:imageName] resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
//}

//-(UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView{
//    return [UIColor colorWithHex:@"007ee5"];
//}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

//-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -70.0;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 10.0;
}


#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView{
    return  YES;
}

//loading - 转圈的是否继续转圈
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return self.loading;
}

//点击图片
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self reTryeAction];
}


//点击重试按钮
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    [self reTryeAction];
}


-(void)reTryeAction{
    self.loading = YES;
//    self.emptyDataSetVisible = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loading = NO;
        [self.tableView.mj_header endRefreshing];
    });
}


#pragma mark - View Auto-Rotation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return NO;
}


#pragma mark - View Auto-Rotation

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{

}


@end
