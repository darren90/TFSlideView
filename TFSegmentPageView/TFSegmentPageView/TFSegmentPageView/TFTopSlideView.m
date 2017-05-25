//
//  TFTopSlideView.m
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/22.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "TFTopSlideView.h"
#import "TFSegmentStyleConfig.h"
#import "TFTitleView.h"
#import "UIView+RRFrame.h"


#define KRandomColor     [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];

CGFloat const KSlideTrackViewWidth = 20;

@interface TFTopSlideView ()<UIScrollViewDelegate> {
    NSUInteger _currentIndex;
}

@property (nonatomic,strong)TFSegmentStyleConfig * config;

// 滚动scrollView
@property (strong, nonatomic) UIScrollView *scrollView;

/** 缓存所有标题label */
@property (nonatomic, strong) NSMutableArray *titleViews;
// 缓存计算出来的每个标题的宽度
@property (nonatomic, strong) NSMutableArray *titleWidths;


@property (nonatomic,weak)TFTitleView *selectTitleView;

@property (nonatomic,copy)TitleDidClickBlock titleDidClick;


//底下横线
@property (nonatomic,strong) UIImageView *lineView;
//设置右边额外距离的时候，需要的横线底下横线
@property (nonatomic,strong) UIImageView *exTraLineView;
//底下追踪的view
@property (nonatomic,strong) UIImageView *trackView;

//真正用到的额外距离
@property (nonatomic,assign) CGFloat realUseExtraMagin;

@end


@implementation TFTopSlideView

static CGFloat const contentSizeXOff = 20.0;


-(instancetype)initWithFrame:(CGRect)frame config:(TFSegmentStyleConfig *)config delegate:(id<TFScrollPageViewDelegate>)delegate titles:(NSArray *)titles titleDidClick:(TitleDidClickBlock)titleDidClick{
    if (self = [super initWithFrame:frame]) {

        self.realUseExtraMagin = self.config.extraEdgeright;
        self.config = config;
        self.titles = titles;
        self.delegate = delegate;
        self.titleDidClick = titleDidClick;

        [self initSub];

    }
    return self;
}

- (void)initSub {
    [self addSubview:self.scrollView];

    [self setupTitles];
    [self setUpTitlesPoistion];

    //额外的距离需要重新调整
    CGFloat scrollW = self.frame.size.width - self.realUseExtraMagin ;
    self.scrollView.frame = CGRectMake(0.0, 0.0, scrollW, self.zj_height);

    [self.scrollView bringSubviewToFront:self.lineView];
    [self.scrollView bringSubviewToFront:self.trackView];

    if (self.realUseExtraMagin > 0) {//右边显示出额外的线条
        [self addSubview:self.exTraLineView];
    }
}

// 添加子控件
- (void)setupTitles {

    if (self.titles.count == 0) return;

    NSInteger index = 0;
    for (NSString *title in self.titles) {

        TFTitleView *titleView = [[TFTitleView alloc] initWithFrame:CGRectZero];
        titleView.tag = index;

        titleView.font = [UIFont systemFontOfSize:self.config.titleFontSize];
        titleView.text = title;
        titleView.textColor = self.config.normalTitleColor;

        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelOnClick:)];
        [titleView addGestureRecognizer:tapGes];

        CGFloat titleViewWidth = [titleView titleViewWidth];
        [self.titleWidths addObject:@(titleViewWidth)];

        [self.titleViews addObject:titleView];
        [self.scrollView addSubview:titleView];

        index++;
    }
}

//设置子控件的frame
- (void)setUpTitlesPoistion {
    CGFloat titleX = 0.0;
    CGFloat titleY = 0.0;
    CGFloat titleW = 0.0;
    CGFloat titleH = self.zj_height;

    NSInteger index = 0;
    float lastLableMaxX = self.config.titleMargin;
    float addedMargin = 0.0f;

    for (TFTitleView *titleView in self.titleViews) {
        titleW = [self.titleWidths[index] floatValue];
        titleX = lastLableMaxX + addedMargin/2;

        lastLableMaxX += (titleW + addedMargin + self.config.titleMargin);

        titleView.frame = CGRectMake(titleX, titleY, titleW, titleH);

        index++;
    }

    //设置默认选中的按钮
    _currentIndex = self.config.defaultSelectIndex;

    //设置选中的状态
    TFTitleView *currentTitleView = (TFTitleView *)self.titleViews[_currentIndex];
//    currentTitleView.currentTransformSx = 1.0;
    if (currentTitleView) {
        // 缩放, 设置初始的label的transform
        currentTitleView.currentTransformSx = self.config.titleBigScale;

        // 设置初始状态文字的颜色
        currentTitleView.textColor = self.config.selectedTitleColor;

        self.selectTitleView = currentTitleView;

        //设置追踪线的位置

        [self adjustTitleViewCenter:currentTitleView];
    }

    //设置滚动区域
    TFTitleView *lastTitleView = (TFTitleView *)self.titleViews.lastObject;
    if (lastTitleView) {
        CGFloat maxX = CGRectGetMaxX(lastTitleView.frame) + contentSizeXOff;
        self.scrollView.contentSize = CGSizeMake(maxX, 0.0);
        self.lineView.zj_width = maxX + 300; //底下线的宽度多给一些，防止把线拽出来了

        // 一行排不下后，右边的额外距离为一个btn宽度，如果排的下，就显示两个按钮
        if ( maxX > self.frame.size.width ) {
            self.realUseExtraMagin = self.config.extraEdgeright;
            self.doubleExtraScreen = NO;
        }else{
            self.realUseExtraMagin = 2 * self.config.extraEdgeright;
            self.doubleExtraScreen = YES;
        }
    }
}


- (void)reloadWithNewTitles:(NSArray *)titles{
    if (self.titles.count == 0) return;

    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _currentIndex = 0;
    self.titleWidths = nil;
    self.titleViews = nil;
    self.lineView = nil;
    self.exTraLineView = nil;
    self.trackView = nil;
    self.titles = nil;
    self.titles = [titles copy];

    [self initSub];
}


#pragma mark - UIScrollViewDelegate


#pragma mark - button action

- (void)titleLabelOnClick:(UITapGestureRecognizer *)tapGes {

    TFTitleView *currentLabel = (TFTitleView *)tapGes.view;

    if (!currentLabel) {
        return;
    }

    _currentIndex = currentLabel.tag;
    [self adjustTitleViewCenter:currentLabel];

//    [self adjustUIWhenBtnOnClickWithAnimate:true taped:YES];

    //设置选中的而一些逻辑

    //恢复原来的形变
    self.selectTitleView.textColor = self.config.normalTitleColor;
    self.selectTitleView.transform = CGAffineTransformIdentity;

    self.selectTitleView = currentLabel;
    currentLabel.textColor = self.config.selectedTitleColor;

    //
    CGFloat scale = self.config.titleBigScale;
    currentLabel.transform = CGAffineTransformMakeScale(scale, scale);

    //选中底下的内容区域
    if (self.titleDidClick) {
        self.titleDidClick(currentLabel, _currentIndex);
    }
}

//滚动scrollview，让选中的阿牛居中
- (void)adjustTitleViewCenter:(TFTitleView *)titleView{

    CGFloat offsetX = titleView.center.x - self.frame.size.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }

    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.frame.size.width + self.realUseExtraMagin;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }

    if (offsetX > 0) {
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }

    CGFloat trackViewX = CGRectGetMinX(titleView.frame) + (CGRectGetWidth(titleView.frame))/2.0 - (KSlideTrackViewWidth)/2.0 ;
    //设置追踪view的位置
    [UIView animateWithDuration:0.3 animations:^{
        self.trackView.frame = CGRectMake(trackViewX, CGRectGetMinY(self.trackView.frame), CGRectGetWidth(self.trackView.frame), CGRectGetHeight(self.trackView.frame));
    }];
}

//进度选中标题
-(void)selctWithProgress:(CGFloat)progress oldIndex:(NSInteger)oldIndex currentIndex:(NSInteger)currentIndex{
    if (oldIndex < 0 || oldIndex >= self.titles.count || currentIndex < 0 ||  currentIndex >= self.titles.count ) {
        return;
    }
//    NSLog(@"-topView-old:%ld,current:%ld,proegress:%f",(long)oldIndex,(long)currentIndex,progress);

//不进行 渐变 了

    TFTitleView *oldTitleView = (TFTitleView *)self.titleViews[oldIndex];
    TFTitleView *currentTitleView = (TFTitleView *)self.titleViews[currentIndex];

    CGFloat scale = self.config.titleBigScale - 1.0;
    oldTitleView.currentTransformSx = self.config.titleBigScale - scale * progress;
    currentTitleView.currentTransformSx = 1.0 + scale * progress;

//    NSLog(@"--old-%f",self.config.titleBigScale - scale * progress);
//
//    UIColor *nColor = [self getColorOfPercent:progress between:self.config.normalTitleColor and:self.config.selectedTitleColor];
//    UIColor *sColor = [self getColorOfPercent:progress between:self.config.selectedTitleColor and:self.config.normalTitleColor];

//    CGFloat nScale = (self.config.titleBigScale - 1) * progress;
//    CGFloat sScale = 1 - nScale;
//    self.selectTitleView.transform = CGAffineTransformMakeScale(sScale + 1, sScale + 1);
//    currentTitleView.transform = CGAffineTransformMakeScale(nScale + 1, nScale + 1);

//    self.selectTitleView.textColor = nColor;
//    currentTitleView.textColor = sColor;
}

-(void)adjustTitleViewEndDecelerateTocurrentIndex:(NSInteger)currentIndex{
    // 调整字体和缩放
    int index = 0;
    for (TFTitleView *titleView in _titleViews) {
        if (index != currentIndex) {
            titleView.textColor = self.config.normalTitleColor;
            titleView.currentTransformSx = 1.0;
            titleView.backgroundColor = [UIColor whiteColor];
        } else {
            titleView.textColor = self.config.selectedTitleColor;
            titleView.currentTransformSx = self.config.titleBigScale;
            self.selectTitleView = titleView;

            [self adjustTitleViewCenter:titleView];
        }
        index++;
    }

    //调整是否需要居中



//    TFTitleView *currentTitleView = (TFTitleView *)self.titleViews[currentIndex];
//
//    self.selectTitleView.textColor = self.config.normalTitleColor;
//    self.selectTitleView.transform = CGAffineTransformIdentity;
//
//    CGFloat scale = self.config.titleBigScale;
//    currentTitleView.transform = CGAffineTransformMakeScale(scale, scale);
//    currentTitleView.textColor = self.config.selectedTitleColor;

}



- (UIColor *)getColorOfPercent:(CGFloat)percent between:(UIColor *)color1 and:(UIColor *)color2{
    CGFloat red1, green1, blue1, alpha1;
    [color1 getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];

    CGFloat red2, green2, blue2, alpha2;
    [color2 getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];

    CGFloat p1 = percent;
    CGFloat p2 = 1.0 - percent;
    UIColor *mid = [UIColor colorWithRed:red1*p1+red2*p2 green:green1*p1+green2*p2 blue:blue1*p1+blue2*p2 alpha:1.0f];
    return mid;
}

- (UIScrollView *)scrollView {

    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.bounces = YES;
        scrollView.pagingEnabled = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIImageView *)lineView{
    if (_lineView == nil) {
        //add line
        _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(-150, self.frame.size.height - 3 , self.frame.size.width + 300, 1)];
        _lineView.backgroundColor = [UIColor colorWithRed:225/255.0 green:226.0/255.0 blue:227/255.0 alpha:1.0];//(225, 226, 227);
        [self.scrollView addSubview:_lineView];
    }
    return _lineView;
}


- (UIImageView *)exTraLineView{
    if (_exTraLineView == nil) {
        //add line
        _exTraLineView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - self.realUseExtraMagin, self.frame.size.height - 3 ,self.realUseExtraMagin, 1)];
        _exTraLineView.backgroundColor = [UIColor colorWithRed:225/255.0 green:226.0/255.0 blue:227/255.0 alpha:1.0];//(225, 226, 227);
        [self.scrollView addSubview:_exTraLineView];
    }
    return _exTraLineView;
}

- (UIImageView *)trackView{
    if (_trackView == nil) {
        CGFloat trackH = 3;
        _trackView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.lineView.frame) - (trackH - CGRectGetHeight(self.lineView.frame))/2 , KSlideTrackViewWidth, trackH)];
//        _trackView.backgroundColor = [UIColor redColor];//(225, 226, 227);
        _trackView.image = [UIImage imageNamed:@"IC_ON"];
        [self.scrollView addSubview:_trackView];
    }
    return _trackView;
}


- (NSMutableArray *)titleViews
{
    if (_titleViews == nil) {
        _titleViews = [NSMutableArray array];
    }
    return _titleViews;
}

- (NSMutableArray *)titleWidths
{
    if (_titleWidths == nil) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}

@end
