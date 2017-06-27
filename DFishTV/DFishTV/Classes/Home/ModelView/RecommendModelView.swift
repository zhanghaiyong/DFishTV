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
    
    var hotData : AnchorGroup  =  AnchorGroup()
    var prettyData : AnchorGroup =  AnchorGroup()
    
}

extension RecommendModelView {

    func requestDataMethod(finishedCallBack : @escaping () -> ()) {
        
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate()] as [String : Any]
        
        // 2.创建Group
        let Group = DispatchGroup()
        
        Group.enter()
        //最热
        NetworkTools.requestData(type: .GET, url: kHot, finishedCallBack: { (result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            self.hotData.tag_name = "最热"
            self.hotData.icon_name = "home_header_hot"
            self.hotData.room_list = dataArray
            print("dic = \(String(describing: self.hotData))" as AnyObject)
            
            Group.leave()
        })
        
        
        //颜值数据
        Group.enter()
        NetworkTools.requestData(type: .GET, url: kPrettyUrl, params: parameters as? [String : String]) { (result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.prettyData.tag_name = "颜值"
            self.prettyData.icon_name = "home_header_phone"
            self.prettyData.room_list = dataArray
            
            Group.leave()
        }
        
        Group.enter()
        //底部分类
        NetworkTools.requestData(type: .GET, url: kOtherUrl, finishedCallBack: { (result) in
            let dic = result as? [String : AnyObject]
            let array : [AnyObject] = dic?["data"] as! [AnyObject]
            
            for obj in array {
                
                let group = AnchorGroup()
                let dict : [String : AnyObject] = obj as! Dictionary
                group.icon_url = dict["small_icon_url"] as? String
                group.tag_name = dict["tag_name"] as? String
                group.room_list = dict["room_list"] as? [Any]
                self.dataSurce.append(group)
            }
            
            Group.leave()
        })
        

        // 6.所有的数据都请求到,之后进行排序
        Group.notify(queue: DispatchQueue.main) {
            
            self.dataSurce.insert(self.prettyData, at: 0)
            self.dataSurce.insert(self.hotData, at: 0)
            
            //这个block回调，说明数据请求完毕
            finishedCallBack()
        }
        
    }
}
