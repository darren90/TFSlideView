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
#import "TFGravity.h"

/**
文件布局 TFSegmentPageView :
                顶部：TFTopSlideView
           中间的内容：TFContentView

 */


@interface TFSegmentPageView ()

@property (nonatomic,weak)TFContentView * contentView;

@property (nonatomic,weak)UIViewController * fatherVc;


//@property (nonatomic,strong)NSArray * childVcArray;

@property (nonatomic,copy)NSArray * titlesArray;

@property (nonatomic,strong)TFSegmentStyleConfig * config;

//弹性吸附
@property (nonatomic, strong) UIDynamicAnimator *animator;

//气泡View
@property (nonatomic,weak)UIImageView * bubbleView;

@end

@implementation TFSegmentPageView
CGFloat const ContentMarginEdge = 18;

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
    self.titlesArray = nil;
    self.titlesArray = newTitles.copy;

    [self.topView reloadWithNewTitles:self.titlesArray];
    [self.contentView reloadNewTitles];
}

-(void)initSub{
    self.topView.backgroundColor = [UIColor whiteColor];
    [self initImageView];
    self.contentView.backgroundColor = [UIColor whiteColor];
}


-(void)initImageView{
    UIImage *image = [UIImage imageNamed:@"bg_blue-1"];
    UIImageView *icon = [[UIImageView alloc]initWithImage:image];
    [self addSubview:icon];
    icon.contentMode = UIViewContentModeScaleToFill;
    CGFloat h = self.frame.size.width * (image.size.height / image.size.width * 1.0 );
    icon.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.frame.size.width, h);
    self.bubbleView = icon;

//    [self startAnimate];

//    icon.backgroundColor = [UIColor cyanColor];
    // 初始化仿真者
//    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
//    self.animator = animator;
//
//    CGPoint anchorPoint = icon.center;
//    UIOffset offset = UIOffsetMake(0.01, 0.01);
//
//    // 3. 添加附着行为
//    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:icon offsetFromCenter:offset attachedToAnchor:anchorPoint];
//    attachment.frequency = 1.1f;
//    attachment.damping = 10;
//    [self.animator addBehavior:attachment];
//
//    // 频率(让线具有弹性)
//    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[icon]];
//    [self.animator addBehavior:gravity];
}


-(void)startAnimate {
    #define SPEED 50
    float scrollSpeed = (self.bubbleView.frame.size.width - self.frame.size.width)/2/SPEED;

    //注意：此处时间间隔如果给0.01 iOS8下由于未知原因弹出键盘会导致cpu消耗大于100%
    [TFGravity sharedGravity].timeInterval = 0.02;
    [[TFGravity sharedGravity]startDeviceMotionUpdatesBlock:^(float x, float y, float z) {
        NSLog(@"-xyz-:%f-%f-%f",x,y,z);

        [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{

            if (self.bubbleView.frame.origin.x <=0 && self.bubbleView.frame.origin.x >= self.frame.size.width - self.bubbleView.frame.size.width) {
                float invertedYRotationRate = y * -1.0;

                float interpretedXOffset = self.bubbleView.frame.origin.x + invertedYRotationRate * (self.bubbleView.frame.size.width/[UIScreen mainScreen].bounds.size.width) * scrollSpeed + self.bubbleView.frame.size.width/2;

                self.bubbleView.center = CGPointMake(interpretedXOffset, self.bubbleView.center.y);
            }

            if (self.bubbleView.frame.origin.x >0) {
                self.bubbleView.frame = CGRectMake(0, self.bubbleView.frame.origin.y, self.bubbleView.frame.size.width, self.bubbleView.frame.size.height);
            }
            if (self.bubbleView.frame.origin.x < self.frame.size.width - self.bubbleView.frame.size.width)  {
                self.bubbleView.frame = CGRectMake(self.frame.size.width - self.bubbleView.frame.size.width, self.bubbleView.frame.origin.y, self.bubbleView.frame.size.width, self.bubbleView.frame.size.height);
            }
        } completion:nil];


    }];
}

-(void)stopAnimate {
    [[TFGravity sharedGravity] stop];
}


-(TFTopSlideView *)topView{
    if (_topView == nil) {

        __weak __typeof(self) weakSelf = self;
        CGRect topRect = CGRectMake(0, 0, self.frame.size.width, self.config.topHeight);
        TFTopSlideView *tView = [[TFTopSlideView alloc]initWithFrame:topRect config:self.config delegate:self.delegate titles:self.titlesArray  titleDidClick:^(TFTitleView *titleView, NSInteger index) {
            [weakSelf.contentView selectIndex:index animated:NO];
        }] ;
        [self addSubview:tView];
        _topView = tView;
    }
    return _topView;
}

-(TFContentView *)contentView{
    if (_contentView == nil) {
        CGRect contentRect = CGRectMake(ContentMarginEdge, CGRectGetMaxY(self.topView.frame) + ContentMarginEdge, self.frame.size.width - 2 * ContentMarginEdge, self.frame.size.height - CGRectGetMaxY(self.topView.frame));
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









