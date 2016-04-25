//
//  TFScrollTabbarView.h
//  TFSlideView_OC
//
//  Created by Tengfei on 16/4/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFScrollTabbarItem :NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) CGFloat width;
+ (TFScrollTabbarItem *)itemWithTitle:(NSString *)title width:(CGFloat)width;

@end

@protocol TFSlideTabbarDelegate <NSObject>

- (void)DLSlideTabbar:(id)sender selectAt:(NSInteger)index;

@end


@interface TFScrollTabbarView : UIView
@property(nonatomic, strong) UIView *backgroundView;

// tabbar属性
@property (nonatomic, strong) UIColor *tabItemNormalColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *tabItemSelectedColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat tabItemNormalFontSize;
@property(nonatomic, strong) UIColor *trackColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) NSArray *tabbarItems;

// DLSlideTabbarProtocol
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, readonly) NSInteger tabbarCount;
@property(nonatomic, weak) id<TFSlideTabbarDelegate> delegate;
- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent;

 
@end
