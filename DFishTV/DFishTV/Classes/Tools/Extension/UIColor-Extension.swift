//
//  UIColor-Extension.swift
//  DFishTV
//
//  Created by 张海勇 on 2017/6/16.
//  Copyright © 2017年 张海勇. All rights reserved.
//

import UIKit

extension UIColor {

     //便利构造函数：1>convenience开头 2>在便利构造函数中必须明确调用一个设计的构造函数(self调用)
    convenience init(r : CGFloat,g : CGFloat,b : CGFloat) {
        
        self.init(red : r/255.0,green : g/255.0,blue : b/255.0, alpha: 1)
    }
}
