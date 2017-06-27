//
//  RecommendModelView.swift
//  DFishTV
//
//  Created by zhy on 2017/6/27.
//  Copyright © 2017年 张海勇. All rights reserved.
//

import UIKit

class RecommendModelView: NSObject {

    var dataSurce : [AnchorGroup] = [AnchorGroup]()
    
    var hotData   =  AnchorGroup()
    var otherData : [AnchorGroup] = [AnchorGroup]()
    
}

extension RecommendModelView {

    func requestDataMethod() {
        
        
        let queue = DispatchQueue(label: "queue", qos: .default)
        let group = DispatchGroup()
        
        //最热
        queue.async(group: group, qos: .default, flags: [], execute: {
   
            NetworkTools.requestData(type: .GET, url: kHot, finishedCallBack: { (result) in
                
                let dic = result as? [String : AnyObject]
                let data = dic?["data"] as AnyObject
                let array : [AnyObject] = data as! [AnyObject]
                print("dic = \(String(describing: array))" as AnyObject)
                
                      self.hotData.tag_name = "最热"
                      self.hotData.icon_name = "home_header_hot"
                      self.hotData.room_list = array
                print("dic = \(String(describing: self.hotData))" as AnyObject)
            })
        })
        
        //底部分类
        queue.async(group: group, qos: .default, flags: [], execute: {

            NetworkTools.requestData(type: .GET, url: kOtherType, finishedCallBack: { (result) in                
                let dic = result as? [String : AnyObject]
                let array : [AnyObject] = dic?["data"] as! [AnyObject]
                
                for obj in array {
                    
                    let group = AnchorGroup()
                    let dict : [String : AnyObject] = obj as! Dictionary
                    group.icon_url = dict["small_icon_url"] as? String
                    group.tag_name = dict["tag_name"] as? String
                    group.room_list = dict["room_list"] as? [Any]
                    self.otherData.append(group)
                }
            })
        })
        
        group.notify(queue: queue) {
            self.dataSurce.append(self.hotData)
            self.dataSurce += self.otherData
        }
    }
}
