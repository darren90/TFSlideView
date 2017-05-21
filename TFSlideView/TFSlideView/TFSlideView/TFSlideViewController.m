//
//  TFSlideViewController.m
//  TFSlideView
//
//  Created by Fengtf on 2017/5/11.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "TFSlideViewController.h"
#import "FlowLayout.h"


typedef NS_ENUM(NSInteger, SlideArrangeType) {
    SlideArrangeCenter,    //居中排列
    SlideArrangeAverage,   //平均分布
};

#define KRandomColor     [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];

NSInteger const baseTagNum = 100;
CGFloat const extraWidth = 100;

@interface TFSlideViewCell : UICollectionViewCell


@property (nonatomic,weak)UIView * mainView;


@end


@implementation TFSlideViewCell

//-(void)setMainView:(UIView *)mainView{
//    _mainView = mainView;
//}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView * mainView = [[UIView alloc]init];
        self.mainView = mainView;
        [self.contentView addSubview:mainView];
        self.mainView.frame = self.bounds;
    }
    return self;
}

- (void)setMainView:(UIView *)mainView{
    _mainView = mainView;

}

-(void)layoutSubviews{
    [super layoutSubviews];

    self.mainView.frame = self.bounds;
}

@end

#pragma mark  - TFSlideViewController

@interface TFSlideViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak)UIScrollView *topSrollView;

@property (nonatomic,weak)UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *datas;

@property (nonatomic,strong)NSMutableArray * subVcs;

@property (nonatomic,weak)UIButton * selectBtn;

@property (nonatomic,assign)SlideArrangeType arrangeType;

@end

@implementation TFSlideViewController

-(void)loadView{
    [super loadView];

    CGRect vf = self.view.frame;
    vf.size.width += extraWidth;
    self.view.frame = vf;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTopbtn];
    [self initCollectionView];

    self.topSrollView.backgroundColor = [UIColor cyanColor];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    [self.view layoutIfNeeded];

    self.datas = [NSArray array];

//    [self.view setNeedsLayout];
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
//    NSLog(@"--self.view-:%@",NSStringFromCGRect(self.view.frame));
//    NSLog(@"--topSrollView-:%@",NSStringFromCGRect(self.topSrollView.frame));
    [self.view layoutIfNeeded];

//   NSURL *url = [NSURL URLWithString:nil];
    NSLog(@"--collectionView-:%@",NSStringFromCGRect(self.collectionView.frame));

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


-(NSInteger)normalFontSize{
    if (_normalFontSize == 0) {
        _normalFontSize = 15;
    }
    return _normalFontSize;
}


-(NSInteger)seleFontSize{
    if (_seleFontSize == 0) {
        _seleFontSize = 18;
    }
    return _seleFontSize;
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
    FlowLayout *layout = [[FlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + 10, self.view.frame.size.height) collectionViewLayout:layout];
    self.collectionView  = collectionView;
    [self.view addSubview:collectionView];
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topSrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.0];
    NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[c1,c2,c3,c4]];

    [self.collectionView layoutIfNeeded];

//    collectionView.prefetchingEnabled = NO;
    layout.itemSize = CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
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

//-(BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"-shouldShowMenuForItemAtIndexPath-:%ld",(long)indexPath.item);
//    return NO;
//}

-(BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    NSLog(@"-canPerformAction-:%ld",(long)indexPath.item);
    return NO;
}


#pragma mark - init data

-(void)setTitles:(NSArray *)titles{
    _titles = titles;

    if (titles.count == 0) {
        return;
    }

    [self.topSrollView layoutIfNeeded];

    CGFloat margin = 10;             //btn之间的间距
    CGFloat edgeborder = margin;     //最两边的btn距离父控件两边的距离
    CGFloat totalMargin = margin;
    UIButton *lastbtn = nil;

    UIFont *selctFont = [UIFont systemFontOfSize:self.seleFontSize];
    UIFont *nomalFont = [UIFont systemFontOfSize:self.normalFontSize];

    CGFloat kWidth = self.view.frame.size.width;
    CGFloat totalWith = 0;
    for (int i = 0 ; i< titles.count ; i++) {
        NSString *title = titles[i];

        CGFloat btnW = [title sizeWithAttributes:@{NSFontAttributeName : selctFont}].width + 5 + margin;
        totalWith += btnW;
    }

    //居中排列 时，两边多出来的距离
    CGFloat edgeMargin = 20;
    //判断 是否要居中还是分散排布
    SlideArrangeType arrangeType = SlideArrangeCenter;
    if ((totalWith + 2 * edgeMargin) > kWidth) {
        arrangeType = SlideArrangeAverage;//分散排列
    }
    self.arrangeType = arrangeType;

    for (int i = 0 ; i< titles.count ; i++) {
        NSString *title = titles[i];

        UIButton *btn = [[UIButton alloc]init];
        [self.topSrollView addSubview:btn];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = nomalFont;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchDown];
        btn.tag = i + baseTagNum;

        lastbtn.backgroundColor = KRandomColor;

        CGFloat btnW = [title sizeWithAttributes:@{NSFontAttributeName : selctFont}].width + 5;
        totalMargin += btnW + margin;

        if (arrangeType == SlideArrangeAverage) {
            //分散排列

        }else{
            //居中排列

            edgeborder = ( kWidth -  totalWith) / 2.0;
        }

        NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topSrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        //        NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.topSrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];

        NSLayoutConstraint *c31 = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:CGRectGetHeight(self.topSrollView.frame)];

        NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:btnW];
        [btn addConstraints:@[c3,c31]];

        NSLayoutConstraint *c4;
        if(lastbtn == nil){
            c4 = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topSrollView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:edgeborder];
        }else{
            c4 = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:lastbtn attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:margin];
        }

        if (i == self.initSelctIndex) {
            self.selectBtn = btn;
            [self itemBtnClick:btn];
        }
        
        [self.topSrollView addConstraints:@[c4,c1]];


        lastbtn = btn;
        [self.topSrollView layoutIfNeeded];
        NSLog(@"---btn.frame--:%@",NSStringFromCGRect(btn.frame));
    }

    self.topSrollView.contentSize = CGSizeMake(totalMargin, 30);

    self.datas  = titles;

    [self.collectionView reloadData];
}

-(void)itemBtnClick:(UIButton *)btn{
//    NSLog(@"----itemBtnClick--");

    NSInteger index = btn.tag - baseTagNum;

    UIFont *selctFont = [UIFont systemFontOfSize:self.seleFontSize];
    UIFont *nomalFont = [UIFont systemFontOfSize:self.normalFontSize];

    _selectBtn.titleLabel.font = nomalFont;
    [_selectBtn setTitleColor:self.tabNormalColor forState:UIControlStateNormal];
    [btn setTitleColor:self.tabSelectColor forState:UIControlStateNormal];
    btn.titleLabel.font = selctFont;
    _selectBtn = btn;

    if (self.arrangeType == SlideArrangeAverage) {

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
        
    }else{

    }

    //
    [self selectViewController:index];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //1:选中标题
    NSInteger i = self.collectionView.contentOffset.x / self.view.frame.size.width;
    UIButton *btn = [self.topSrollView viewWithTag:i + baseTagNum];
    if ([btn isKindOfClass:[UIButton class]]){
        [self itemBtnClick:btn];
    }
    //2:把对应的字控制器的view添加上去
    //3:
//    [self setUoOneVc:i];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //字体缩放渐变
//    NSInteger leftI = scrollView.contentOffset.x / self.view.frame.size.width + baseTagNum;
//
//    NSInteger rightI = leftI + 1;
//
//    UIButton *leftBtn = [self.topSrollView viewWithTag:leftI];
//    UIButton *rightBt;
//    if (rightI < (self.topSrollView.subviews.count + baseTagNum)) {
//        rightBt = [self.topSrollView viewWithTag:rightI];
//    }
//
//    //缩放
//    CGFloat scaleR = scrollView.contentOffset.x / self.view.frame.size.width - leftI;
//    CGFloat scaleL = 1 - scaleR;
//
//    leftBtn.transform =  CGAffineTransformMakeScale(0.2*scaleL + 1, 0.2*scaleL + 1);
//    rightBt.transform =  CGAffineTransformMakeScale(0.2*scaleR + 1, 0.2*scaleR + 1);
//
//    //黑色 000 红色100
//    UIColor *righcolor = [UIColor colorWithRed:scaleR green:0.0 blue:0.0 alpha:1.0];
//    UIColor *leftcolor = [UIColor colorWithRed:scaleL green:0.0 blue:0.0 alpha:1.0];
//
//    [rightBt setTitleColor:righcolor forState:UIControlStateNormal];
//    [leftBtn setTitleColor:leftcolor forState:UIControlStateNormal];

}

-(void)selectViewController:(NSInteger)index{
    if (self.datas.count == 0){
        return;
    }

    NSIndexPath *path = [NSIndexPath indexPathForItem:index inSection:0];

    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.datas.count;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

//    collectionView.d
//    NSLog(@"-willDisplayCell : %ld ",(long)indexPath.item);
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

//    NSLog(@"-didEndDisplayingCell : %ld ",(long)indexPath.item);

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TFSlideViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TFSlideViewCell" forIndexPath:indexPath];
    if ([self.deledate respondsToSelector:@selector(TFSlideViewController:didSelectAtIndex:)]) {
        UIViewController *vc =  [self.deledate TFSlideViewController:self didSelectAtIndex:indexPath.row];
        if (![self.subVcs containsObject:vc]) {
            [self addChildViewController:vc];
            vc.view.backgroundColor = KRandomColor;
            vc.view.frame = CGRectMake(0, 0, cell.bounds.size.width - extraWidth, cell.bounds.size.height); //cell.bounds;
            [cell addSubview:vc.view];
//            cell.mainView = vc.view;

            [self.subVcs addObject:vc];
            NSLog(@"----indexPath--:%ld",(long)indexPath.row);
        }else{
            [cell addSubview:vc.view];
//            cell.mainView = vc.view;
        }
    }

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"---:%d ");
    if(indexPath.row % 2 == 0){
        return CGSizeZero;
    }else{
       return CGSizeMake([UIScreen mainScreen].bounds.size.width, collectionView.frame.size.height);
    }
}


-(NSMutableArray *)subVcs{
    if (_subVcs == nil) {
        _subVcs = [NSMutableArray array];
    }
    return _subVcs;
}
 

@end





















