//
//  TFSegmentStyleConfig.m
//  TFSegmentPageView
//
//  Created by Fengtf on 2017/5/22.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "TFSegmentStyleConfig.h"

@implementation TFSegmentStyleConfig

+(instancetype)config{
    TFSegmentStyleConfig *config = [[TFSegmentStyleConfig alloc]init];
    return config;
}
 
-(instancetype)init{
    if (self = [super init]) {
        //set Default value

        self.topHeight = 44;

        self.titleMargin = 20;
        self.titleFontSize = 14;
        self.titleBigScale = 1.5;
        self.normalTitleColor = [UIColor blackColor];
        self.selectedTitleColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:121/255.0 alpha:1.0];

        self.extraEdgeright = 0;
        self.defaultSelectIndex = 0;
    }
    return self;
}

@end
