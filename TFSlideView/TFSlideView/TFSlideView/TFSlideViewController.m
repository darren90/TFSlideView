//
//  TFSlideViewController.m
//  TFSlideView
//
//  Created by Fengtf on 2017/5/11.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "TFSlideViewController.h"

@interface TFSlideViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,weak)UIScrollView *topSrollView;

@property (nonatomic,weak)UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *datas;

@end

@implementation TFSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTopLabel];
    [self initCollectionView];

    self.topSrollView.backgroundColor = [UIColor cyanColor];
    self.collectionView.backgroundColor = [UIColor brownColor];
    [self.view layoutIfNeeded];

    self.datas = [NSArray array];

//    [self.view setNeedsLayout];
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLog(@"--self.view-:%@",NSStringFromCGRect(self.view.frame));
    NSLog(@"--topSrollView-:%@",NSStringFromCGRect(self.topSrollView.frame));
    NSLog(@"--collectionView-:%@",NSStringFromCGRect(self.collectionView.frame));

//   NSURL *url = [NSURL URLWithString:nil];

    [self vv];
}

- (void)vv {
    return;

    UIView *purpleView = [[UIView alloc] init];
    purpleView.backgroundColor = [UIColor purpleColor];
    // 禁止将 AutoresizingMask 转换为 Constraints
    purpleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:purpleView];
    // 添加 width 约束
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:purpleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:150];
    [purpleView addConstraint:widthConstraint];
    // 添加 height 约束
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:purpleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:150];
    [purpleView addConstraint:heightConstraint];
    // 添加 left 约束
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:purpleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:100];
    [self.view addConstraint:leftConstraint];
    // 添加 top 约束
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:purpleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:200];
    [self.view addConstraint:topConstraint];

    NSLog(@"--pp:%@",NSStringFromCGRect(purpleView.frame));
}

#pragma mark - 初始化控件

- (void)initTopLabel{
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;

    UIScrollView *topSrollView = [[UIScrollView alloc]init];
    topSrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.topSrollView = topSrollView;
    [self.view addSubview:topSrollView];
    topSrollView.showsVerticalScrollIndicator = NO;
    topSrollView.alwaysBounceHorizontal = YES;

    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:topSrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.topMagin+20];
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:topSrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:topSrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:topSrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:30.0];

    [topSrollView addConstraint:c4];
    [self.view addConstraints:@[c1,c2,c3]];
    NSLog(@"--topSrollView-1-:%@",NSStringFromCGRect(self.topSrollView.frame));

//    [self.topSrollView setNeedsLayout];
}

- (void)initCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView  = collectionView;
    [self.view addSubview:collectionView];
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topSrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[c1,c2,c3,c4]];

    layout.itemSize = collectionView.frame.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    collectionView.delegate = self;
    collectionView.dataSource = self;

}

#pragma mark - init data

-(void)setTitles:(NSArray *)titles{
    _titles = titles;

    if (titles.count == 0) {
        return;
    }

    NSLog(@"--topSrollView-3-:%@",NSStringFromCGRect(self.topSrollView.frame));
    [self.topSrollView layoutIfNeeded];

    CGFloat margin = 10;
    CGFloat totalMargin = margin;
    UILabel *lastLabel = nil;
    for (int i = 0 ; i< titles.count ; i++) {
        NSString *title = titles[i];

        UILabel *label = [[UILabel alloc]init];
        [self.topSrollView addSubview:label];
        label.text = title;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.textAlignment = NSTextAlignmentCenter;

        if (i % 2 == 0) {
            lastLabel.backgroundColor = [UIColor lightGrayColor];
        }

        CGFloat labelW = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}].width + 5;
//        CGFloat labelX = margin + (labelW + margin) * i;
        totalMargin += labelW + margin + 100;

        NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topSrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.topSrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];

//        NSLayoutConstraint *c31 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:CGRectGetHeight(self.topSrollView.frame)];

        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:labelW];
        [label addConstraints:@[c3]];

        NSLayoutConstraint *c4;
        if(lastLabel == nil){
            c4 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topSrollView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:margin];
        }else{
           c4 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:lastLabel attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:margin];
        }


        [self.topSrollView addConstraints:@[c1,c2,c4]];
        lastLabel = label;
        NSLog(@"---label.frame--:%@",NSStringFromCGRect(label.frame));
    }
//    CGFloat maxX = CGRectGetMaxX(lastLabel.frame);
    self.topSrollView.contentSize = CGSizeMake(totalMargin+1000, 30);
    [self.collectionView reloadData];

    NSLog(@"--topSrollView-2-:%@",NSStringFromCGRect(self.topSrollView.frame));

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

 

@end
