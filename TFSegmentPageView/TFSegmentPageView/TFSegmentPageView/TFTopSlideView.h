//
//  TFTopSlideView.h
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/22.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFSegmentStyleConfig.h"
#import "TFSegmentPageView.h"

@class TFSegmentPageView;
@interface TFTopSlideView : UIView

- (instancetype)initWithFrame:(CGRect )frame config:(TFSegmentStyleConfig *)config delegate:(id<TFScrollPageViewDelegate>)delegate titles:(NSArray *)titles;


@end
