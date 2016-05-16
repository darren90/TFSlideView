//
//  TFMultiSlideView.h
//  TFSlideView_OC
//
//  Created by Fengtf on 16/5/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLSlideTabbarProtocol.h"
#import "DLSlideView.h"
#import "DLTabedSlideView.h"
#import "DLCacheProtocol.h"


@class TFMultiSlideView;
@protocol TFMultiSlideViewDelegate <NSObject>
- (NSInteger)numberOfTabsInDLCustomSlideView:(TFMultiSlideView *)sender;
- (UIViewController *)DLCustomSlideView:(TFMultiSlideView *)sender controllerAt:(NSInteger)index;
@optional
- (void)DLCustomSlideView:(TFMultiSlideView *)sender didSelectedAt:(NSInteger)index;
@end

#pragma mark - Delegate

@interface TFMultiSlideView : UIView<DLSlideTabbarDelegate, DLSlideViewDelegate, DLSlideViewDataSource>

@property(nonatomic, weak) UIViewController *baseViewController;
@property(nonatomic, assign) NSInteger selectedIndex;

// tabbar
@property(nonatomic, strong) UIView<DLSlideTabbarProtocol> *tabbar;
@property(nonatomic, assign) float tabbarBottomSpacing;

// cache properties
@property(nonatomic, strong) id<DLCacheProtocol> cache;

// delegate
@property(nonatomic, weak)IBOutlet id<TFMultiSlideViewDelegate>delegate;

// init method. 初始分方法
- (void)setup;
@end
