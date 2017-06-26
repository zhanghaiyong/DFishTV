//
//  NetworkTools.swift
//  DFishTV
//
//  Created by 张海勇 on 2017/6/26.
//  Copyright © 2017年 张海勇. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    
    //@escaping 逃逸闭包 函数执行完成之后调用
    class func requestData(type : MethodType,url : String,params : [String : String]? = nil,finishedCallBack :  @escaping (_ result : AnyObject) -> ()) {
    
        //1.获取请求类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in
            
            guard let result = response.result.value else{
                print(response.result.error as Any)
                return
            }
            finishedCallBack(result as AnyObject)
            
        }
        
    }
    
}
