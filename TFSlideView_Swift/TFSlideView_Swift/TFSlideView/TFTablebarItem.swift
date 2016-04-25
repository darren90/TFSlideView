//
//  TFTablebarItem.swift
//  TFSlideView_Swift
//
//  Created by Tengfei on 16/3/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class TFTablebarItem: NSObject {
    var title:String!
    
    
    class func itemWithTitle(title:String) -> TFTablebarItem{
        let item = TFTablebarItem()
        item.title = title
        return item
    }
    
}
