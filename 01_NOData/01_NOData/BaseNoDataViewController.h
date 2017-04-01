//
//  NoDataViewController.h
//  Applications
//
//  Created by Fengtf on 2017/3/28.
//  Copyright © 2017年 DZN Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNoDataViewController : UITableViewController

@property (nonatomic,assign)int page;

@property (nonatomic, assign) BOOL loading;

-(void)reTryeAction;

@end
