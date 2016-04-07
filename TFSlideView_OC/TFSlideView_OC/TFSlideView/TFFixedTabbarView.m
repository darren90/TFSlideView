//
//  TFFixedTabbarView.m
//  TFSlideView_OC
//
//  Created by Fengtf on 16/4/7.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFFixedTabbarView.h"
#import "DLUtility.h"
//#import ""
#import "TFCommon.h"

#define kTrackViewHeight 2
#define kImageSpacingX 3.0f

#define kBGViewTagBase 8000

#define kLabelTagBase 1000
#define kSubLabelTagBase 2000


#define KMargin 30
#define KMarginMore 0//margin多出来的地址
#define KTrackMargin 6//margin多出来的地址


#pragma mark - TFFixedTabbarViewTabItem

@implementation TFFixedTabbarViewTabItem

@end

#pragma mark - TFFixedTabbarView

@interface TFFixedTabbarView()

@property (nonatomic,strong)NSMutableArray * sizeArray;

@property (nonatomic,assign)CGFloat totalLabelW;


@property (nonatomic,assign)BOOL isFirstEnter;

@end

@implementation TFFixedTabbarView
{
    UIScrollView *scrollView_;
    UIImageView *backgroudView_;
    UIImageView *trackView_;
}

- (void)commonInit{
    _selectedIndex = -1;
    
    backgroudView_ = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:backgroudView_];
    
    scrollView_ = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scrollView_];
    
    trackView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-kTrackViewHeight-1, self.bounds.size.width, kTrackViewHeight)];
    [self addSubview:trackView_];
    trackView_.layer.cornerRadius = 2.0f;
    
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    //    [scrollView_ addGestureRecognizer:tap];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        self.isFirstEnter = YES;
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage{
    backgroudView_.image = backgroundImage;
}

- (void)setTrackColor:(UIColor *)trackColor{
    trackView_.backgroundColor = trackColor;
}

- (void)setTabbarItems:(NSArray *)tabbarItems{
    if (_tabbarItems != tabbarItems) {
        _tabbarItems = tabbarItems;
        
        assert(tabbarItems.count <= 4);
        
        float width = self.bounds.size.width/tabbarItems.count;
        float height = self.bounds.size.height;
        float x = 0.0f;
        NSInteger i = 0;
        for (TFFixedTabbarViewTabItem *item in tabbarItems) {
            //添加View。label添加到view上，居中
            x = x*width;
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(x, 0, width, height)];
//            bgView.backgroundColor = KRandomColor;
            bgView.tag = kBGViewTagBase + i;
            
            UILabel *label = [[UILabel alloc] initWithFrame:bgView.bounds];
            if (!item.titleFont) {
                item.titleFont = [UIFont systemFontOfSize:15];
            }
            label.font = item.titleFont;
            label.backgroundColor = [UIColor clearColor];
//            label.textColor = item.titleColor;
 
            NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:item.title];

            if ([item.title containsString:@"("]) {
                NSRange range = [item.title rangeOfString:@"("];
                [attStr addAttributes:@{NSForegroundColorAttributeName:item.titleColor , NSFontAttributeName : item.titleFont} range:NSMakeRange(0, range.location)];
                [attStr addAttributes:@{NSForegroundColorAttributeName:item.titleColor , NSFontAttributeName : [UIFont systemFontOfSize:12]} range:NSMakeRange(range.location, item.title.length - (range.location))];
            }else{
                [attStr addAttributes:@{NSForegroundColorAttributeName:item.titleColor , NSFontAttributeName : item.titleFont} range:NSMakeRange(0, item.title.length)];
            }
    
//            label.text = item.title;
            label.attributedText = attStr;

            //            [label sizeToFit];
            //            label.center = bgView.center;
            label.textAlignment = NSTextAlignmentCenter;
            
            label.tag = kLabelTagBase + i;
            
            CGSize labelSize = [label.text sizeWithAttributes:@{NSFontAttributeName : label.font}];
            
            [self.sizeArray addObject:[NSValue valueWithCGSize:labelSize]];
            self.totalLabelW += labelSize.width;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [label addGestureRecognizer:tap];

            [bgView addSubview:label];
            [scrollView_ addSubview:bgView];

            i++;
            label.userInteractionEnabled = YES;
        }
//            [self layoutTabbar];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    backgroudView_.frame = self.bounds;
    scrollView_.frame = self.bounds;
    
    [self layoutTabbar];
}

#pragma - mark 这里的label的宽度是一样的，字数不一样的label底线的显示会存在问题
- (void)layoutTabbar{
    if (self.isFirstEnter == NO)  return;
    self.isFirstEnter = NO;
    
    NSInteger count = self.tabbarItems.count;
//    float width = self.bounds.size.width/count;
    float height = self.bounds.size.height;
//    float x = 0.0f;
    //最左，最后各 多 留10的间距
    float inset = 20;
    float margin = (self.bounds.size.width - 2*inset - self.totalLabelW) / count;
    CGFloat labelX =  inset ;

    for (NSInteger i=0; i< count; i++) {
        //取出bgView
        UIView *bgView = (UIView *)[scrollView_ viewWithTag:kBGViewTagBase + i];

        NSValue *sizeValue = self.sizeArray[i];
        CGSize labelSize = [sizeValue CGSizeValue];
        labelX +=  margin;
         CGFloat labelY = (height - labelSize.height) / 2;
        bgView.frame = CGRectMake(labelX, labelY, labelSize.width, labelSize.height);;
        labelX += labelSize.width;
        UILabel *label = (UILabel *)[bgView viewWithTag:kLabelTagBase + i];
  
        label.frame = bgView.bounds;
//        label.backgroundColor = KRandomColor;
    }
    
    //设置初始的TrachView的位置
    UIView *bgView = (UIView *)[scrollView_ viewWithTag:kBGViewTagBase + 0];//取出第一个
    CGFloat labelW = CGRectGetWidth(bgView.bounds);
    float trackX =  bgView.frame.origin.x - KTrackMargin;
    
    trackView_.frame = CGRectMake(trackX, trackView_.frame.origin.y, labelW+2*KTrackMargin, kTrackViewHeight);
}

- (NSInteger)tabbarCount{
    return self.tabbarItems.count;
}

- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent{
    TFFixedTabbarViewTabItem *fromItem = [self.tabbarItems objectAtIndex:fromIndex];
    UIView *fromView = (UIView *)[scrollView_ viewWithTag:kBGViewTagBase + fromIndex];
    UILabel *fromLabel = (UILabel *)[fromView viewWithTag:kLabelTagBase + fromIndex];
    fromLabel.textColor = [DLUtility getColorOfPercent:percent between:fromItem.titleColor and:fromItem.selectedTitleColor];
    
    if (toIndex >= 0 && toIndex < [self tabbarCount]) {
        TFFixedTabbarViewTabItem *toItem = [self.tabbarItems objectAtIndex:toIndex];
        UIView *bgView = (UIView *)[scrollView_ viewWithTag:kBGViewTagBase + toIndex];
        UILabel *toLabel = (UILabel *)[bgView viewWithTag:kLabelTagBase + toIndex];
        toLabel.textColor = [DLUtility getColorOfPercent:percent between:toItem.selectedTitleColor and:toItem.titleColor];

    UIView *fromBgView = (UIView *)[scrollView_ viewWithTag:kBGViewTagBase + fromIndex];//sure
    UIView *toBgView = (UIView *)[scrollView_ viewWithTag:kBGViewTagBase + toIndex];//sure
    CGFloat labelW = CGRectGetWidth(toBgView.bounds);
    float trackX =  fromBgView.frame.origin.x - KTrackMargin;
    if (toIndex > fromIndex) {
        trackX = trackX + labelW * percent;
    }
    else{
        trackX = trackX - labelW * percent;
    }
    NSLog(@"from:%ld--to:%ld,x:%f",(long)fromIndex,(long)toIndex,trackX);
    
    trackView_.frame = CGRectMake(trackX, trackView_.frame.origin.y, labelW + 2 * KTrackMargin, CGRectGetHeight(trackView_.bounds));
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    if (_selectedIndex != selectedIndex) {
        if (_selectedIndex >= 0) {
            TFFixedTabbarViewTabItem *fromItem = [self.tabbarItems objectAtIndex:_selectedIndex];
//            UIView *bgView = (UIView *)[scrollView_ viewWithTag:kBGViewTagBase + _selectedIndex];
            UILabel *fromLabel = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+_selectedIndex];
            fromLabel.textColor = fromItem.titleColor;
        }
        if (selectedIndex >= 0 && selectedIndex < [self tabbarCount]) {
            TFFixedTabbarViewTabItem *toItem = [self.tabbarItems objectAtIndex:selectedIndex];
//            UIView *bgView = (UIView *)[scrollView_ viewWithTag:kBGViewTagBase + selectedIndex];
            UILabel *toLabel = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+selectedIndex];
            toLabel.textColor = toItem.selectedTitleColor;
        }
 
        UIView *bgView = (UIView *)[scrollView_ viewWithTag:kBGViewTagBase + selectedIndex];
        float trackX = CGRectGetMinX(bgView.frame) - KTrackMargin;
        NSLog(@"selectedIndex:%ld--:%f",(long)selectedIndex,trackX);

        trackView_.frame = CGRectMake(trackX, trackView_.frame.origin.y, CGRectGetWidth(bgView.bounds)+2*KTrackMargin, CGRectGetHeight(trackView_.bounds));
        NSLog(@"");
        
        _selectedIndex = selectedIndex;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    NSInteger i = tap.view.tag - kLabelTagBase;
    self.selectedIndex = i;
    if (self.delegate) {
        [self.delegate DLSlideTabbar:self selectAt:i];
    }
}

-(NSMutableArray *)sizeArray
{
    if (!_sizeArray) {
        _sizeArray = [NSMutableArray array];
    }
    return _sizeArray;
}

@end
