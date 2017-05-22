//
//  TFSegmentPageView.m
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/22.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "TFSegmentPageView.h"
#import "TFContentView.h"
#import "TFTopSlideView.h"



/**
文件布局 TFSegmentPageView :
                顶部：TFTopSlideView
           中间的内容：TFContentView

 */


@interface TFSegmentPageView ()

@property (nonatomic,weak)TFContentView * contentView;

@property (nonatomic,weak)TFTopSlideView * topView;

@property (nonatomic,weak)UIViewController * fatherVc;


//@property (nonatomic,strong)NSArray * childVcArray;

@property (nonatomic,copy)NSArray * titlesArray;


@property (nonatomic,strong)TFSegmentStyleConfig * config;


@end

@implementation TFSegmentPageView


-(instancetype)initWithFrame:(CGRect)frame config:(TFSegmentStyleConfig *)config titles:(NSArray<NSString *> *)titles parentViewController:(UIViewController *)parentViewController delegate:(id<TFScrollPageViewDelegate>)delegate{
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        if (config == nil) {
            config = [TFSegmentStyleConfig config];
        }
        self.config = config;
        self.delegate = delegate;
        
        self.titlesArray = titles;

        [self initSub];
    }
    return self;
}

//刷新的接口
-(void)reloadNewTitles:(NSArray<NSString *> *)newTitles{

}

-(void)initSub{
    self.topView.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

-(TFTopSlideView *)topView{
    if (_topView == nil) {
        CGRect topRect = CGRectMake(0, 0, self.frame.size.width, self.config.topHeight);
        TFTopSlideView *tView = [[TFTopSlideView alloc]initWithFrame:topRect config:self.config delegate:self.delegate titles:self.titlesArray];
        [self addSubview:tView];
        _topView = tView;
    }
    return _topView;
}

-(TFContentView *)contentView{
    if (_contentView == nil) {
        CGRect contentRect = CGRectMake(0.0, CGRectGetMaxY(self.topView.frame), self.frame.size.width, self.frame.size.height - CGRectGetMaxY(self.topView.frame));
        TFContentView *cView = [[TFContentView alloc]initWithFrame:contentRect topView:self.topView parentViewController:self.fatherVc delegate:self.delegate];
        [self addSubview:cView];
        _contentView = cView;
    }
    return _contentView;
}


#pragma makr - gabbage

//-(NSArray *)childVcArray{
//    if (_childVcArray == nil) {
//        _childVcArray = [NSArray array];
//    }
//    return _childVcArray;
//}

-(NSArray *)titlesArray{
    if (_titlesArray == nil) {
        _titlesArray = [NSArray array];
    }
    return _titlesArray;
}



@end









