//
//  TFContentView.m
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/22.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "TFContentView.h"

@interface TFContentView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    CGFloat   _oldOffSetX;
}
@property (nonatomic,weak)id<TFScrollPageViewDelegate> delegate;
@property (nonatomic,weak)UIViewController * fatherVc;

@property (nonatomic,weak)UICollectionView * collectionView;

@property (assign, nonatomic) NSInteger itemsCount;

@property (assign, nonatomic) NSInteger currentIndex;
@property (assign, nonatomic) NSInteger oldIndex;

@property (nonatomic,assign)float systemVersion;


@property (nonatomic,weak)TFTopSlideView * topView;


// 当前控制器
@property (strong, nonatomic, readonly) UIViewController *currentChildVc;

@property (strong, nonatomic) NSMutableDictionary<NSString *, UIViewController *> *childVcsDic;


@end

NSString * const cellID = @"cellID";

@implementation TFContentView

-(instancetype)initWithFrame:(CGRect)frame topView:(TFTopSlideView *)topView parentViewController:(UIViewController *)parentViewController delegate:(id<TFScrollPageViewDelegate>)delegate{
    if (self = [super initWithFrame:frame]) {
        self.fatherVc = parentViewController;
        self.topView= topView;
        self.systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        self.delegate = delegate;

        [self initSub];
    }
    return self;
}

-(void)initSub{
    _currentIndex = 0;
    _oldOffSetX = 0.0;

    [self addSubview:self.collectionView];

    if ([self.delegate respondsToSelector:@selector(numberOfItemsInPageView:)]) {
        self.itemsCount = [self.delegate numberOfItemsInPageView:nil];
    }else{
        NSAssert(NO, @"请实现代理方法");
    }
    
    [self.collectionView reloadData];
}


-(void)layoutSubviews{
    [super layoutSubviews];


}


- (void)reloadNewTitles{

    [self.childVcsDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, UIViewController * _Nonnull childVc, BOOL * _Nonnull stop) {
        [TFContentView removeChildVc:childVc];
        childVc = nil;

    }];
    self.childVcsDic = nil;
    [self initSub];
    [self.collectionView reloadData];
//    [self setContentOffSet:CGPointZero animated:NO];
    [self selectIndex:0 animated:NO];
}

+ (void)removeChildVc:(UIViewController *)childVc {
    [childVc willMoveToParentViewController:nil];
    [childVc.view removeFromSuperview];
    [childVc removeFromParentViewController];
}


#pragma mark - UICollectionViewDelegate --- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _itemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    // 移除subviews 避免重用内容显示错误
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    if (self.systemVersion < 8.0) {
        [self setupChildVcForCell:cell atIndexPath:indexPath];
    }

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.systemVersion >= 8.0) {
        [self setupChildVcForCell:cell atIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)setupChildVcForCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndex != indexPath.row) {
        return;
    }

    NSString *key = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
    _currentChildVc = self.childVcsDic[key];
    
//    BOOL isFirstLoad = (_currentChildVc == nil);
    
    if (_currentChildVc == nil) {
        _currentChildVc = [self.delegate pageView:nil vcForRowAtIndex:indexPath.item];
        
        //set value for diction
        self.childVcsDic[key] = _currentChildVc;
    }
    
    if (_currentChildVc.parentViewController != self.fatherVc) {
        [self.fatherVc addChildViewController:_currentChildVc];
    }
    
    _currentChildVc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:_currentChildVc.view];
    NSLog(@"---current:%@",NSStringFromCGRect(_currentChildVc.view.frame));
    [_currentChildVc didMoveToParentViewController:self.fatherVc];
    [_currentChildVc.view layoutIfNeeded];
}

- (void)selectIndex:(NSInteger)index animated:(BOOL)animated{
    if (index >= _itemsCount) {
        return;
    }

    _oldIndex = _currentIndex;
    _currentIndex = index;

    NSIndexPath *path = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x <= 0 || scrollView.contentOffset.x >= scrollView.contentSize.width - scrollView.bounds.size.width) {
        return;
    }


    CGFloat tempProgress = scrollView.contentOffset.x / self.bounds.size.width;
    NSInteger tempIndex = tempProgress;

    CGFloat progress = tempProgress - floor(tempProgress);
    CGFloat deltaX = scrollView.contentOffset.x - _oldOffSetX;

    if (deltaX > 0) {// 向左
        if (progress == 0.0) {
            return;
        }
        self.currentIndex = tempIndex + 1;
        self.oldIndex = tempIndex;
    } else if (deltaX < 0) {
        progress = 1.0 - progress;
        self.oldIndex = tempIndex + 1;
        self.currentIndex = tempIndex;

    } else {
        return;
    }


    //选中上面的TitleView
    if(self.topView){
        [self.topView selctWithProgress:progress oldIndex:self.oldIndex currentIndex:self.currentIndex];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _oldOffSetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentIndex = (scrollView.contentOffset.x / self.bounds.size.width);

    if(self.topView){
        [self.topView adjustTitleViewEndDecelerateTocurrentIndex:currentIndex];
    }
}

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        [collectionView setBackgroundColor:[UIColor whiteColor]];
        collectionView.pagingEnabled = YES;
        collectionView.scrollsToTop = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.bounces = YES;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
        collectionView.bounces =  YES;
        collectionView.scrollEnabled = YES;
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;

}

-(NSMutableDictionary<NSString *,UIViewController *> *)childVcsDic{
    if (_childVcsDic == nil) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        _childVcsDic = dic;
    }
    return _childVcsDic;
}


@end
