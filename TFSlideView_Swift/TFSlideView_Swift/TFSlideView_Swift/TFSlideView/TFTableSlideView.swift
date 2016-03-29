//
//  TFTableSlideView.swift
//  TFSlideView_Swift
//
//  Created by Tengfei on 16/3/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit


public protocol TFTableSlideViewDelegate: NSObjectProtocol {
    // optional public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    
//    func numberOfItemTableSlideView(slideView: TFTableSlideView) -> Int
    func numberOfItemTableSlideView() -> Int
    
//    - (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index;
//    @optional
//    - (void)DLTabedSlideView:(DLTabedSlideView *)sender didSelectedAt:(NSInteger)index;
    func tableSlideViewControllerAt(index:Int) -> UIViewController
    
    func tableSlideViewDidSelectedAt(index:Int)

}

class TFTableSlideView: UIView {
    
    var baseViewController:UIViewController!
    var selectedIndex:Int!
    
    var tabItemNormalColor:UIColor!
    var tabItemSelectedColor:UIColor!
    var tabbarBackgroundImage:UIColor!
    var tabbarTrackColor:UIColor!
    var tabbarItems:Array<AnyObject>!
    var tabbarHeight:Float!
    var tabbarBottomSpacing:Float!
    
    var cacheCount:Int!
    
    weak var delegate:TFTableSlideViewDelegate?

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

//@protocol DLSlideTabbarDelegate <NSObject>
//- (void)DLSlideTabbar:(id)sender selectAt:(NSInteger)index;
//@end
//
//@protocol DLSlideTabbarProtocol <NSObject>
//@property(nonatomic, assign) NSInteger selectedIndex;
//@property(nonatomic, readonly) NSInteger tabbarCount;
//@property(nonatomic, weak) id<DLSlideTabbarDelegate> delegate;
//- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent;
//@end


protocol TFSlideTabbarDelegate {
    func TFSlideTabbar(sender:AnyClass,index:Int)

}

protocol TFSlideTabbarProtocol {
    var selectedIndex:Int  { get }
    var tabbarCount:Int { get }
    var delegate:TFSlideTabbarDelegate { get }
//    - (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent;
    func switchingFrom(fromIndex:Int,toIndex:Int,percent:Float)
    
}












