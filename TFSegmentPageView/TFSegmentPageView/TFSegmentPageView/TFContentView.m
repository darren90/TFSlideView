//
//  TFContentView.m
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/22.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "TFContentView.h"

@interface TFContentView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,weak)id<TFScrollPageViewDelegate> delegate;
@property (nonatomic,weak)UIViewController * fatherVc;

@property (nonatomic,weak)UICollectionView * collectionView;

@property (assign, nonatomic) NSInteger itemsCount;

@property (assign, nonatomic) NSInteger currentIndex;
@property (assign, nonatomic) NSInteger oldIndex;

@property (nonatomic,assign)float systemVersion;

// 当前控制器
@property (strong, nonatomic, readonly) UIViewController *currentChildVc;

@property (strong, nonatomic) NSMutableDictionary<NSString *, UIViewController *> *childVcsDic;


@end

NSString * const cellID = @"cellID";

@implementation TFContentView

-(instancetype)initWithFrame:(CGRect)frame topView:(TFTopSlideView *)topView parentViewController:(UIViewController *)parentViewController delegate:(id<TFScrollPageViewDelegate>)delegate{
    if (self = [super initWithFrame:frame]) {
        self.fatherVc = parentViewController;

        self.systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];

        [self initSub];
        self.delegate = delegate;
    }
    return self;
}

-(void)initSub{

    [self addSubview:self.collectionView];

    if ([self.delegate respondsToSelector:@selector(numberOfItemsInPageView:)]) {
        self.itemsCount = [self.delegate numberOfItemsInPageView:nil];
    }else{
        NSAssert(NO, @"请实现代理方法");
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];


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
//        [self setupChildVcForCell:cell atIndexPath:indexPath];
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

    self.currentChildVc =

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


@end
