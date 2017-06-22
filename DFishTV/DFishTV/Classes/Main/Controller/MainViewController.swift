//
//  MainViewController.swift
//  DFishTV
//
//  Created by 张海勇 on 2017/6/14.
//  Copyright © 2017年 张海勇. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Discovery")
        addChildVc(storyName: "Profile")
        
    }
    
    private func addChildVc(storyName : String) {
    
        let childVc = UIStoryboard.init(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    }



}
