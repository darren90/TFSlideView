//
//  TFFixedTabbarView.h
//  TFSlideView_OC
//
//  Created by Fengtf on 16/4/7.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLSlideTabbarProtocol.h"

#pragma mark - TFFixedTabbarViewTabItem
@interface TFFixedTabbarViewTabItem : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIImage *selectedImage;
@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, strong) UIColor *selectedTitleColor;


/**
 *  字体大小
 */
@property (nonatomic,strong)UIFont * titleFont;

@end

#pragma mark - TFFixedTabbarView

@interface TFFixedTabbarView : UIView<DLSlideTabbarProtocol>

@property(nonatomic, strong) UIImage *backgroundImage;
@property(nonatomic, strong) UIColor *trackColor;
@property(nonatomic, strong) NSArray *tabbarItems;

@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, readonly) NSInteger tabbarCount;
@property(nonatomic, weak) id<DLSlideTabbarDelegate> delegate;
- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent;


@end
