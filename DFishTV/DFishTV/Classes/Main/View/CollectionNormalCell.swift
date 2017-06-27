//
//  CollectionNormalCell.swift
//  DFishTV
//
//  Created by 张海勇 on 2017/6/22.
//  Copyright © 2017年 张海勇. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var normal_online: UIButton!
    @IBOutlet weak var normal_img: UIImageView!
    @IBOutlet weak var normal_player: UIButton!
    @IBOutlet weak var normal_roomName: UILabel!
    
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
            self.normal_online.setTitle(onlineStr, for: .normal)
            
            //玩家
            self.normal_player.setTitle(anchor?.nickname, for: .normal)
            
            //房间名
            guard anchor?.room_name != nil else {
                return
            }
            self.normal_roomName.text = anchor?.room_name
            
            //封面
            guard anchor?.room_src != nil else {
                return
            }
            let imgUrl = URL.init(string: (anchor?.room_src)!)
            self.normal_img.kf.setImage(with: imgUrl)

            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
