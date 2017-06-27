//
//  CollectionHeaderView.swift
//  DFishTV
//
//  Created by 张海勇 on 2017/6/22.
//  Copyright © 2017年 张海勇. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var collectionHeaderTitle: UILabel!
    @IBOutlet weak var collectionHeaderImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var group : AnchorGroup? {
    
        didSet {
        
            guard group != nil else {
                return
            }
            
            //标题
            guard group?.tag_name != nil else {
                return
            }
            self.collectionHeaderTitle.text = group?.tag_name
            
            //图标
            if group?.icon_name == nil {
            
                guard group?.icon_url != nil else {
                    return
                }
                let url = URL.init(string: (group?.icon_url)!)
                self.collectionHeaderImg.kf.setImage(with: url)
            }else {
            
                self.collectionHeaderImg.image = UIImage(named: (group?.icon_name)!)
            }
            
            
        }
    }
    
}
