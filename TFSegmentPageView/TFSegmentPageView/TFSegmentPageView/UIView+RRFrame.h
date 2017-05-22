//
//  UIView+RRFrame.h
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/22.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RRFrame)

///** 重置X的坐标 */
//@property (nonatomic,assign)CGFloat centerX;
//
///** 重置中心的 */
//@property (nonatomic,assign)CGFloat centerY;

@property (nonatomic, assign) CGFloat zj_centerX;
@property (nonatomic, assign) CGFloat zj_centerY;

@property (nonatomic, assign) CGFloat zj_x;
@property (nonatomic, assign) CGFloat zj_y;
@property (nonatomic, assign) CGFloat zj_width;
@property (nonatomic, assign) CGFloat zj_height;

@end
