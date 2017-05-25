//
//  TFTopSlideView.h
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/22.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFSegmentStyleConfig.h"
#import "TFScrollPageViewDelegate.h"

@class TFSegmentPageView;
@class TFTitleView;

typedef void(^TitleDidClickBlock)(TFTitleView *titleView,NSInteger index) ;

@interface TFTopSlideView : UIView

// 所有的标题
@property (strong, nonatomic) NSArray *titles;

@property (nonatomic,weak)id<TFScrollPageViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect )frame config:(TFSegmentStyleConfig *)config delegate:(id<TFScrollPageViewDelegate>)delegate titles:(NSArray *)titles titleDidClick:(TitleDidClickBlock)titleDidClick;


- (void)selctWithProgress:(CGFloat)progress oldIndex:(NSInteger)oldIndex currentIndex:(NSInteger)currentIndex;

//停止滚动后，调整顶部view的颜色，缩放等等。
- (void)adjustTitleViewEndDecelerateTocurrentIndex:(NSInteger)currentIndex;

/** 重新刷新标题的内容*/
- (void)reloadWithNewTitles:(NSArray *)titles;


//是否有2倍的额外屏幕距离
@property (nonatomic,assign)BOOL doubleExtraScreen;

@end
