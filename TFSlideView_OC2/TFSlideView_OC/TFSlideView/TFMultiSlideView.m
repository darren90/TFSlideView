//
//  TFMultiSlideView.m
//  TFSlideView_OC
//
//  Created by Fengtf on 16/5/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFMultiSlideView.h"

#define kDefaultTabbarBottomSpacing 0
#define kDefaultCacheCount 4

@interface TFMultiSlideView()

@end

@implementation TFMultiSlideView
{
    DLSlideView *slideView_;
}

- (void)commonInit{
    self.tabbarBottomSpacing = kDefaultTabbarBottomSpacing;
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
    }
    return self;
}

- (void)setup{
    //每次built前，清空其子控件，防止重绘的时候重影
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.tabbar.delegate = self;
    [self addSubview:self.tabbar];
    
    slideView_ = [[DLSlideView alloc] initWithFrame:CGRectMake(0, self.tabbar.frame.size.height+self.tabbarBottomSpacing, self.bounds.size.width, self.bounds.size.height-self.tabbar.frame.size.height-self.tabbarBottomSpacing)];
    slideView_.delegate = self;
    slideView_.dataSource = self;
    slideView_.baseViewController = self.baseViewController;
    [self addSubview:slideView_];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self layoutBarAndSlide];
}

- (void)layoutBarAndSlide{
    self.tabbar.frame = CGRectMake(0, 0, CGRectGetWidth(self.tabbar.bounds), self.tabbar.frame.size.height);
    slideView_.frame = CGRectMake(0, self.tabbar.frame.size.height+self.tabbarBottomSpacing, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.tabbar.frame.size.height-self.tabbarBottomSpacing);
}

- (void)setBaseViewController:(UIViewController *)baseViewController{
    slideView_.baseViewController = baseViewController;
    _baseViewController = baseViewController;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [slideView_ setSelectedIndex:selectedIndex];
    [self.tabbar setSelectedIndex:selectedIndex];
}

- (void)DLSlideTabbar:(id)sender selectAt:(NSInteger)index{
    [slideView_ setSelectedIndex:index];
}

- (NSInteger)numberOfControllersInDLSlideView:(DLSlideView *)sender{
    return [self.delegate numberOfTabsInDLCustomSlideView:self];
}

- (UIViewController *)DLSlideView:(DLSlideView *)sender controllerAt:(NSInteger)index{
    NSString *key = [NSString stringWithFormat:@"%ld", (long)index];
    if ([self.cache objectForKey:key]) {
        return [self.cache objectForKey:key];
    }
    else{
        UIViewController *ctrl = [self.delegate DLCustomSlideView:self controllerAt:index];
        [self.cache setObject:ctrl forKey:key];
        return ctrl;
    }
}

- (void)DLSlideView:(DLSlideView *)slide switchingFrom:(NSInteger)oldIndex to:(NSInteger)toIndex percent:(float)percent{
    [self.tabbar switchingFrom:oldIndex to:toIndex percent:percent];
}
- (void)DLSlideView:(DLSlideView *)slide didSwitchTo:(NSInteger)index{
    [self.tabbar setSelectedIndex:index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(DLTabedSlideView:didSelectedAt:)]) {
        [self.delegate DLCustomSlideView:self didSelectedAt:index];
    }
}
- (void)DLSlideView:(DLSlideView *)slide switchCanceled:(NSInteger)oldIndex{
    [self.tabbar setSelectedIndex:oldIndex];
}


@end
