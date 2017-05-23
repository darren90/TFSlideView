//
//  TFSegmentStyleConfig.h
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/22.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFSegmentStyleConfig : NSObject

+(instancetype)config;



//顶部的高度
@property (nonatomic,assign)CGFloat topHeight;


/** 标题之间的间隙 默认为15.0 */
@property (assign, nonatomic) CGFloat titleMargin;
/** 标题的字体 默认为14 */
@property (assign, nonatomic) CGFloat titleFontSize;
/** 标题缩放倍数, 默认1.3 */
@property (assign, nonatomic) CGFloat titleBigScale;
/** 标题一般状态的颜色 */
@property (strong, nonatomic) UIColor *normalTitleColor;
/** 标题选中状态的颜色 */
@property (strong, nonatomic) UIColor *selectedTitleColor;


/** 是否显示附加的按钮 默认为NO*/
@property (assign, nonatomic, getter=isShowExtraButton) BOOL showExtraButton;

/** 右边的二额外的距离 默认:0*/
@property (nonatomic,assign)CGFloat extraEdgeright;

/** 默认选中的Item 默认为0*/
@property (nonatomic,assign)NSInteger defaultSelectIndex;


@end
