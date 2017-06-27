//
//  CollectionPrettyCell.swift
//  DFishTV
//
//  Created by 张海勇 on 2017/6/23.
//  Copyright © 2017年 张海勇. All rights reserved.
//

import UIKit

class CollectionPrettyCell: UICollectionViewCell {

    @IBOutlet weak var pretty_online: UIButton!
    @IBOutlet weak var pretty_img: UIImageView!
    @IBOutlet weak var pretty_adds: UIButton!
    @IBOutlet weak var pretty_player: UIButton!
    
    
    
    var anchor : AnchorModel? {
        
        didSet {
            
            guard anchor != nil else {
                return
            }
            
            //在线人数
            var onlineStr : String = ""
            if (anchor?.online)! >= 10000 {
                
                onlineStr = " " + "\(Int((anchor?.online)! / 10000))万在线" + " "
            }else {
                
                onlineStr = " " + "\((anchor?.online)!)" + "在线" + " "
            }
            self.pretty_online.setTitle(onlineStr, for: .normal)
            
            //玩家
            self.pretty_player.setTitle(anchor?.nickname, for: .normal)
            
            //地址
            guard anchor?.anchor_city != nil else {
                return
            }
            self.pretty_adds.setTitle(anchor?.anchor_city, for: .normal)
            
            //封面
            guard anchor?.room_src != nil else {
                return
            }
            let imgUrl = URL.init(string: (anchor?.room_src)!)
            self.pretty_img.kf.setImage(with: imgUrl)
            
            
            
        }
    }

}
