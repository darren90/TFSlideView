//
//  TFScrollPageViewDelegate.h
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/25.
//  Copyright © 2017年 ftf. All rights reserved.
//

#ifndef TFScrollPageViewDelegate_h
#define TFScrollPageViewDelegate_h


@class TFSegmentPageView;
@protocol TFScrollPageViewDelegate <NSObject>

@required

- (NSInteger)numberOfItemsInPageView:(TFSegmentPageView *)pageView;
- (UIViewController *)pageView:(TFSegmentPageView *)pageView vcForRowAtIndex:(NSInteger)index;

@optional

@end

#endif /* TFScrollPageViewDelegate_h */
