//
//  TFContentView.h
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/22.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFSegmentStyleConfig.h"
#import "TFTopSlideView.h"
#import "TFSegmentPageView.h"

@class TFSegmentPageView;
@interface TFContentView : UIView

- (instancetype)initWithFrame:(CGRect)frame topView:(TFTopSlideView *)topView parentViewController:(UIViewController *)parentViewController delegate:(id<TFScrollPageViewDelegate>) delegate;

@end
