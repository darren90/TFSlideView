//
//  TFTitleView.h
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/23.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFTitleView : UIView
@property (assign, nonatomic) CGFloat currentTransformSx;


@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic, getter=isSelected) BOOL selected;

/** 代理方法中推荐只设置下面的属性, 当然上面的属性设置也会有效, 不过建议上面的设置在style里面设置 */
@property (strong, nonatomic) UIImage *normalImage;
@property (strong, nonatomic) UIImage *selectedImage;

@property (strong, nonatomic, readonly) UIImageView *imageView;

@property (strong, nonatomic) UILabel *label;


- (CGFloat)titleViewWidth ;
- (void)adjustSubviewFrame;


@end
