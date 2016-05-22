//
//  TFSlideView.h
//  TFSlideView_OC
//
//  Created by Tengfei on 16/4/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFSlideView;

@protocol TFSlideViewDataSource <NSObject>
- (NSInteger)numberOfControllersInTFSlideView:(TFSlideView *)sender;
- (UIViewController *)TFSlideView:(TFSlideView *)sender controllerAt:(NSInteger)index;
@end


#pragma mark - TFSlideViewDelegate


@protocol TFSlideViewDelegate <NSObject>
@optional
- (void)TFSlideView:(TFSlideView *)slide switchingFrom:(NSInteger)oldIndex to:(NSInteger)toIndex percent:(float)percent;
- (void)TFSlideView:(TFSlideView *)slide didSwitchTo:(NSInteger)index;
- (void)TFSlideView:(TFSlideView *)slide switchCanceled:(NSInteger)oldIndex;
@end


#pragma mark - TFSlideView


@interface TFSlideView : UIView
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, weak) UIViewController *baseViewController;
@property(nonatomic, weak) id<TFSlideViewDelegate>delegate;
@property(nonatomic, weak) id<TFSlideViewDataSource>dataSource;
- (void)switchTo:(NSInteger)index;
@end
