//
//  TFSlideViewController.m
//  TFSlideView
//
//  Created by Fengtf on 2017/5/11.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "TFSlideViewController.h"



#define KRandomColor     [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];



@interface TFSlideViewCell : UICollectionViewCell


@property (nonatomic,weak)UIView * mainView;


@end


@implementation TFSlideViewCell

-(void)setMainView:(UIView *)mainView{
    _mainView = mainView;

}


@end

#pragma mark  - TFSlideViewController

@interface TFSlideViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,weak)UIScrollView *topSrollView;

@property (nonatomic,weak)UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *datas;

@property (nonatomic,strong)NSMutableArray * subVcs;


@property (nonatomic,weak)UIButton * selectBtn;


@end

@implementation TFSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTopbtn];
    [self initCollectionView];

    self.topSrollView.backgroundColor = [UIColor cyanColor];
    self.collectionView.backgroundColor = [UIColor brownColor];
    [self.view layoutIfNeeded];

    self.datas = [NSArray array];

//    [self.view setNeedsLayout];
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
//    NSLog(@"--self.view-:%@",NSStringFromCGRect(self.view.frame));
//    NSLog(@"--topSrollView-:%@",NSStringFromCGRect(self.topSrollView.frame));
//    NSLog(@"--collectionView-:%@",NSStringFromCGRect(self.collectionView.frame));
    [self.view layoutIfNeeded];

//   NSURL *url = [NSURL URLWithString:nil];

}

-(UIColor *)tabNormalColor{
    if (_tabNormalColor == nil) {
        _tabNormalColor = [UIColor blackColor];
    }
    return _tabNormalColor;
}

-(UIColor *)tabSelectColor{
    if (_tabSelectColor == nil) {
        _tabSelectColor = [UIColor redColor];
    }
    return _tabSelectColor;
}


#pragma mark - 初始化控件

- (void)initTopbtn{
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
//    NSLog(@"--topSrollView-1-:%@",NSStringFromCGRect(self.topSrollView.frame));
    topSrollView.showsHorizontalScrollIndicator = NO;
    [self.topSrollView layoutIfNeeded];
    [self.view layoutIfNeeded];
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

    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[TFSlideViewCell class] forCellWithReuseIdentifier:@"TFSlideViewCell"];

    [self.collectionView layoutIfNeeded];
}

#pragma mark - init data

-(void)setTitles:(NSArray *)titles{
    _titles = titles;

    if (titles.count == 0) {
        return;
    }

    [self.topSrollView layoutIfNeeded];

    CGFloat margin = 10;
    CGFloat totalMargin = margin;
    UIButton *lastbtn = nil;
    for (int i = 0 ; i< titles.count ; i++) {
        NSString *title = titles[i];

        UIButton *btn = [[UIButton alloc]init];
        [self.topSrollView addSubview:btn];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;

        lastbtn.backgroundColor = KRandomColor;

        CGFloat btnW = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}].width + 5;
        totalMargin += btnW + margin;

        NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topSrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
//        NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.topSrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];

        NSLayoutConstraint *c31 = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:CGRectGetHeight(self.topSrollView.frame)];

        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:btnW];
        [btn addConstraints:@[c3,c31]];

        NSLayoutConstraint *c4;
        if(lastbtn == nil){
            c4 = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topSrollView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:margin];
        }else{
           c4 = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:lastbtn attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:margin];
        }

        if (i == self.initSelctIndex) {
            self.selectBtn = btn;
        }

        [self.topSrollView addConstraints:@[c4,c1]];
        lastbtn = btn;
        [self.topSrollView layoutIfNeeded];
        NSLog(@"---btn.frame--:%@",NSStringFromCGRect(btn.frame));
    }

//    CGFloat maxX = CGRectGetMaxX(lastbtn.frame);
    self.topSrollView.contentSize = CGSizeMake(totalMargin, 30);

    self.datas  = titles;

    [self.collectionView reloadData];
}

-(void)itemBtnClick:(UIButton *)btn{
    NSLog(@"----itemBtnClick--");

    [_selectBtn setTitleColor:self.tabNormalColor forState:UIControlStateNormal];
    [btn setTitleColor:self.tabSelectColor forState:UIControlStateNormal];
    _selectBtn = btn;

    // 标题居中
    CGFloat offsetX = btn.center.x - self.view.frame.size.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }

    CGFloat maxOffsetX = self.topSrollView.contentSize.width - self.view.frame.size.width;
    if(offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.topSrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];

    //
    [self selectViewController:btn.tag];
}

-(void)selectViewController:(NSInteger)index{
    
    NSIndexPath *path = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TFSlideViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TFSlideViewCell" forIndexPath:indexPath];
    if ([self.deledate respondsToSelector:@selector(TFSlideViewController:didSelectAtIndex:)]) {
        UIViewController *vc =  [self.deledate TFSlideViewController:self didSelectAtIndex:indexPath.row];
        if (![self.subVcs containsObject:vc]) {
            [self addChildViewController:vc];
            vc.view.backgroundColor = KRandomColor;
            vc.view.frame = cell.bounds;
            [cell addSubview:vc.view];
        }else{
            [cell addSubview:vc.view];
        }
    }

    return cell;
}


-(NSMutableArray *)subVcs{
    if (_subVcs == nil) {
        _subVcs = [NSMutableArray array];
    }
    return _subVcs;
}
 

@end





















