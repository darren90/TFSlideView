//
//  TFTabedSlideView.m
//  TFSlideView_OC
//
//  Created by Fengtf on 16/4/7.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFTabedSlideView.h"
//#import "DLFixedTabbarView.h"
#import "TFFixedTabbarView.h"
#import "DLSlideView.h"
#import "DLLRUCache.h"

#define kDefaultTabbarHeight 34
#define kDefaultTabbarBottomSpacing 0
#define kDefaultCacheCount 4


#pragma mark - TFTabedbarItem

@implementation TFTabedbarItem
+ (TFTabedbarItem *)itemWithTitle:(NSString *)title
{
    TFTabedbarItem *item = [[TFTabedbarItem alloc] init];
    item.title = title;
    return item;
    
}

+ (TFTabedbarItem *)itemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    TFTabedbarItem *item = [[TFTabedbarItem alloc] init];
    item.title = title;
    item.image = image;
    item.selectedImage = selectedImage;
    return item;
}

@end



#pragma mark - TFTabedSlideView

@interface TFTabedSlideView ()<DLSlideViewDelegate, DLSlideViewDataSource>

@end

@implementation TFTabedSlideView
{
    DLSlideView *slideView_;
    TFFixedTabbarView *tabbar_;
    DLLRUCache *ctrlCache_;
}


- (void)commonInit{
    self.tabbarHeight = kDefaultTabbarHeight;
    self.tabbarBottomSpacing = kDefaultTabbarBottomSpacing;
    
    tabbar_ = [[TFFixedTabbarView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.tabbarHeight)];
    tabbar_.delegate = self;
    [self addSubview:tabbar_];
    
    slideView_ = [[DLSlideView alloc] initWithFrame:CGRectMake(0, self.tabbarHeight+self.tabbarBottomSpacing, self.bounds.size.width, self.bounds.size.height-self.tabbarHeight-self.tabbarBottomSpacing)];
    slideView_.delegate = self;
    slideView_.dataSource = self;
    [self addSubview:slideView_];
    
    ctrlCache_ = [[DLLRUCache alloc] initWithCount:4];
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

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self layoutBarAndSlide];
}

- (void)layoutBarAndSlide{
    UIView *barView = (UIView *)tabbar_;
    barView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), self.tabbarHeight);
    slideView_.frame = CGRectMake(0, self.tabbarHeight+self.tabbarBottomSpacing, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.tabbarHeight-self.tabbarBottomSpacing);
    
}
 
- (void)setBaseViewController:(UIViewController *)baseViewController{
    slideView_.baseViewController = baseViewController;
}

- (void)buildTabbar{
    NSMutableArray *tabbarItems = [NSMutableArray array];
    for (TFTabedbarItem *item in self.tabbarItems) {
        TFFixedTabbarViewTabItem *barItem = [[TFFixedTabbarViewTabItem alloc] init];
        barItem.title = item.title;
        barItem.titleColor = self.tabItemNormalColor;
        barItem.selectedTitleColor = self.tabItemSelectedColor;
        barItem.image = item.image;
        barItem.selectedImage = item.selectedImage;
        barItem.titleFont = self.titleFont;
        
        [tabbarItems addObject:barItem];
    }
    
    tabbar_.tabbarItems = tabbarItems;
    tabbar_.trackColor = self.tabbarTrackColor;
    tabbar_.backgroundImage = self.tabbarBackgroundImage;
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [slideView_ setSelectedIndex:selectedIndex];
    [tabbar_ setSelectedIndex:selectedIndex];
}

- (void)DLSlideTabbar:(id)sender selectAt:(NSInteger)index{
    [slideView_ setSelectedIndex:index];
}

- (NSInteger)numberOfControllersInDLSlideView:(DLSlideView *)sender{
    return [self.delegate numberOfTabsInDLTabedSlideView:self];
}

- (UIViewController *)DLSlideView:(DLSlideView *)sender controllerAt:(NSInteger)index{
    NSString *key = [NSString stringWithFormat:@"%ld", (long)index];
    if ([ctrlCache_ objectForKey:key]) {
        return [ctrlCache_ objectForKey:key];
    }
    else{
        UIViewController *ctrl = [self.delegate TFTabedSlideView:self controllerAt:index];
        [ctrlCache_ setObject:ctrl forKey:key];
        return ctrl;
    }
}

- (void)DLSlideView:(DLSlideView *)slide switchingFrom:(NSInteger)oldIndex to:(NSInteger)toIndex percent:(float)percent{
    [tabbar_ switchingFrom:oldIndex to:toIndex percent:percent];
}
- (void)DLSlideView:(DLSlideView *)slide didSwitchTo:(NSInteger)index{
    [tabbar_ setSelectedIndex:index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(TFTabedSlideView:didSelectedAt:)]) {
        [self.delegate TFTabedSlideView:self didSelectedAt:index];
    }
}
- (void)DLSlideView:(DLSlideView *)slide switchCanceled:(NSInteger)oldIndex{
    [tabbar_ setSelectedIndex:oldIndex];
}


@end









