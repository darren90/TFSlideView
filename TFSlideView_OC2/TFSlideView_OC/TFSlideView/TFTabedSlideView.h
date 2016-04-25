//
//  TFTabedSlideView.h
//  TFSlideView_OC
//
//  Created by Fengtf on 16/4/7.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLSlideTabbarProtocol.h"

#pragma mark - TFTabedbarItem
@interface TFTabedbarItem : NSObject
@property (nonatomic, strong) NSString *title;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIImage *selectedImage;

+ (TFTabedbarItem *)itemWithTitle:(NSString *)title;


+ (TFTabedbarItem *)itemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;
@end

#pragma mark -  TFTabedSlideViewDelegate


@class TFTabedSlideView;

@protocol TFTabedSlideViewDelegate <NSObject>
- (NSInteger)numberOfTabsInDLTabedSlideView:(TFTabedSlideView *)sender;
- (UIViewController *)TFTabedSlideView:(TFTabedSlideView *)sender controllerAt:(NSInteger)index;
@optional
- (void)TFTabedSlideView:(TFTabedSlideView *)sender didSelectedAt:(NSInteger)index;
@end



#pragma mark - TFTabedSlideView

@interface TFTabedSlideView : UIView

//@property(nonatomic, strong) NSArray *viewControllers;
@property(nonatomic, weak) UIViewController *baseViewController;
@property(nonatomic, assign) NSInteger selectedIndex;


//set tabbar properties.
@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property(nonatomic, strong) UIImage *tabbarBackgroundImage;
@property(nonatomic, strong) UIColor *tabbarTrackColor;
@property(nonatomic, strong) NSArray *tabbarItems;
@property(nonatomic, assign) float tabbarHeight;
@property(nonatomic, assign) float tabbarBottomSpacing;

/**
 *  字体大小
 */
@property (nonatomic,strong)UIFont * titleFont;

// cache properties
@property(nonatomic, assign) NSInteger cacheCount;

- (void)buildTabbar;

//@property(nonatomic, strong) IBOutlet id<DLSlideTabbarProtocol> tabarView;


@property(nonatomic, weak)IBOutlet id<TFTabedSlideViewDelegate>delegate;


@end
