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

    }
    return self;
}

@end
