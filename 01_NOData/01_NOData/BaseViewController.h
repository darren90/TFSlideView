//
//  BaseViewController.h
//  01_NOData
//
//  Created by Fengtf on 2017/3/31.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>

// 下载状态
typedef NS_ENUM(NSUInteger, RequestState) {
    RRDownloadStateNone,       // 没有错误  --> 移除loading
    RRDownloadStateNoNet,      // 没有网络  --> 显示错误界面loading
    RRDownloadStateNoData,     // 没有数据  --> 显示没有数据的界面loading
};


@interface BaseViewController : UIViewController


@property (nonatomic,strong)UIImage * nodataImgage;

//请求
-(void)request;

//开始动画
-(void)startAnimate;


//结束动画
-(void)stopAnimate;


//请求后的状态
@property (nonatomic,assign)RequestState requestState;

@end
