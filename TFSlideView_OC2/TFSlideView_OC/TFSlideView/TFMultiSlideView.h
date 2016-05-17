//
//  TFMultiSlideView.h
//  TFSlideView_OC
//
//  Created by Fengtf on 16/5/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFScrollTabbarView.h"
#import "TFSlideView.h"
#import "TFPageSlideView.h"
#import "TFLRUCache.h"

//#import "DLSlideTabbarProtocol.h"
//#import "DLSlideView.h"
//#import "DLTabedSlideView.h"
//#import "DLCacheProtocol.h"

@class TFMultiSlideView;
@protocol TFMultiSlideViewDelegate <NSObject>
- (NSInteger)numberOfTabsInTFCustomSlideView:(TFMultiSlideView *)sender;
- (UIViewController *)TFCustomSlideView:(TFMultiSlideView *)sender controllerAt:(NSInteger)index;
@optional
- (void)TFCustomSlideView:(TFMultiSlideView *)sender didSelectedAt:(NSInteger)index;
@end

#pragma mark - Delegate

@interface TFMultiSlideView : UIView<TFSlideTabbarDelegate, TFSlideViewDelegate, TFSlideViewDataSource>

@property(nonatomic, weak) UIViewController *baseViewController;
@property(nonatomic, assign) NSInteger selectedIndex;

// tabbar
@property(nonatomic, strong) UIView<TFSlideTabbarProtocol> *tabbar;
@property(nonatomic, assign) float tabbarBottomSpacing;

// cache properties
@property(nonatomic, strong) id<TFLRUCacheProtocol> cache;

// delegate
@property(nonatomic, weak)IBOutlet id<TFMultiSlideViewDelegate>delegate;

// init method. 初始分方法
- (void)setup;

@end
