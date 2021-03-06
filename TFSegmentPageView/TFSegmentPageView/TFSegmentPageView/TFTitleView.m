//
//  TFTitleView.m
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/23.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "TFTitleView.h"

@interface TFTitleView (){
    CGSize _titleSize;
}


@end

@implementation TFTitleView

- (instancetype)init{
    if (self = [super initWithFrame:CGRectZero]) {

    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.iconView = [[UIImageView alloc] init];
        self.iconView.contentMode = UIViewContentModeCenter;
        self.iconView.frame = self.bounds;
        self.iconView.hidden = YES;
        [self addSubview:self.iconView];

        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
//        _isShowImage = NO;
        [self addSubview:self.label];
        self.label.frame = self.bounds;

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.iconView.frame = self.bounds;

    self.label.frame = self.bounds;
}

- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (void)setCurrentTransformSx:(CGFloat)currentTransformSx {
    _currentTransformSx = currentTransformSx;
    
    self.transform = CGAffineTransformMakeScale(currentTransformSx, currentTransformSx);
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.label.font = font;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
    CGRect bounds = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.label.font} context:nil];
    _titleSize = bounds.size;

    if ([text isEqualToString:@"美国"]) {
        self.label.hidden = YES;
        self.iconView.hidden = NO;
        UIImage *im = [UIImage imageNamed:@"ic_tianjiagengduo"];
        self.iconView.image = im;
        _titleSize = im.size;
    }
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;

    self.label.textColor = textColor;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;

//    self.iconView.highlighted = selected;
}

- (CGFloat)titleViewWidth {
    CGFloat width =width = _titleSize.width;;
    return width;
}

- (void)adjustSubviewFrame{
    
}

@end





















