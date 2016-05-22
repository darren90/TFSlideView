//
//  TFScrollTabbarView.h
//  TFSlideView_OC
//
//  Created by Tengfei on 16/4/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - TFSlideTabbarDelegate
@protocol TFSlideTabbarDelegate <NSObject>
- (void)TFSlideTabbar:(id)sender selectAt:(NSInteger)index;
@end


#pragma mark - TFSlideTabbarProtocol
@protocol TFSlideTabbarProtocol <NSObject>
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, readonly) NSInteger tabbarCount;
@property(nonatomic, weak) id<TFSlideTabbarDelegate> delegate;
- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent;
@end


@interface TFScrollTabbarItem :NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) CGFloat width;
+ (TFScrollTabbarItem *)itemWithTitle:(NSString *)title width:(CGFloat)width;
@end

#pragma mark - TFScrollTabbarView

@interface TFScrollTabbarView : UIView
@property(nonatomic, strong) UIView *backgroundView;

// tabbar属性
@property (nonatomic, strong) UIColor *tabItemNormalColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *tabItemSelectedColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat tabItemNormalFontSize;
@property(nonatomic, strong) UIColor *trackColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) NSArray *tabbarItems;
@property(nonatomic, strong) NSArray *mutiItems;//item数据

@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, readonly) NSInteger tabbarCount;
@property(nonatomic, weak) id<TFSlideTabbarDelegate> delegate;
- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent;

@end



