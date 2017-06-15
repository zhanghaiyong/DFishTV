//
//  UIBarButton-Extension.swift
//  DFishTV
//
//  Created by 张海勇 on 2017/6/15.
//  Copyright © 2017年 张海勇. All rights reserved.
//

//对系统类做扩展
import UIKit

extension UIBarButtonItem {

    //类方法
    class func creatItem(imageName:String,highImageName:String,size:CGSize) -> UIBarButtonItem {
        let point = CGPoint(x: 0, y: 0)
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:highImageName), for: .normal)
        btn.frame = CGRect(origin: point, size: size)
        return UIBarButtonItem(customView: btn)
    }
    
    //便利构造函数：1>convenience开头 2>在便利构造函数中必须明确调用一个设计的构造函数(self调用)
    convenience init(imageName:String,highImageName:String = "",size:CGSize = CGSize.zero) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        
        if highImageName != "" {
            btn.setImage(UIImage(named:highImageName), for: .normal)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        //设计的构造函数
        self.init(customView : btn)
    }
    
}
