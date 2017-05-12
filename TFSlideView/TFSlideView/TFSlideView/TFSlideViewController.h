//
//  TFSlideViewController.h
//  TFSlideView
//
//  Created by Fengtf on 2017/5/11.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger, TFSlideViewShowType){
    TFSlideViewShowLine,  //显示底部的线
    TFSlideViewShowRect,  //显示为周围的颜色框
    TFSlideViewShowNone,  //什么都不显示
};

@class TFSlideViewController;
@protocol TFSlideViewControllerDelegate <NSObject>

@optional
-(UIViewController *)TFSlideViewController:(TFSlideViewController *)sendVc didSelectAtIndex:(NSInteger)index;

@end

@interface TFSlideViewController : UIViewController

/** 标题 */
@property (nonatomic,strong)NSArray * titles;
/** 正常状态 ，未选中状态的颜色 */
@property (nonatomic,strong)UIColor * tabNormalColor;
/** 选中的标题颜色 */
@property (nonatomic,strong)UIColor * tabSelectColor;
/** 默认选中的第几个 */
@property(nonatomic,assign)NSInteger initSelctIndex;
/** 距离顶部的距离 */
@property (nonatomic,assign)CGFloat topMagin;



@end
