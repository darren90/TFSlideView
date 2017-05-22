//
//  TFSegmentPageView.h
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/22.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFSegmentStyleConfig.h"

@class TFSegmentPageView;
@protocol TFScrollPageViewDelegate <NSObject>

@required

- (NSInteger)numberOfItemsInPageView:(TFSegmentPageView *)pageView;
- (UIViewController *)pageView:(TFSegmentPageView *)pageView vcForRowAtIndex:(NSInteger)index;

@optional

@end

@interface TFSegmentPageView : UIView

@property (nonatomic,weak)id<TFScrollPageViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame config:(TFSegmentStyleConfig *)config titles:(NSArray<NSString *> *)titles parentViewController:(UIViewController *)parentViewController delegate:(id<TFScrollPageViewDelegate>) delegate ;


/**  给外界重新设置的标题的方法(同时会重新加载页面的内容) */
- (void)reloadNewTitles:(NSArray<NSString *> *)newTitles;


@end
