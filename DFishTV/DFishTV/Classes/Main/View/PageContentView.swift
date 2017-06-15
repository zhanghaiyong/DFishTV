//
//  PageContentView.swift
//  DFishTV
//
//  Created by 张海勇 on 2017/6/16.
//  Copyright © 2017年 张海勇. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellID"

class PageContentView: UIView {
    
    var childVcs : [UIViewController]
    weak var parentViewController : UIViewController?
    
    //MARK:懒加载属性
    lazy var collectionView : UICollectionView = {[weak self] in
        
        //1.创建layout
        //流水布局
        let layout = UICollectionViewFlowLayout()
        //布局大小
        layout.itemSize = (self?.bounds.size)!
        //行间距
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
        
        }()
    

    
    //MARK:自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],parentViewController : UIViewController?) {
    
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK:设置UI界面
extension PageContentView {

    func setupUI() {
    
        //1.将所有的字控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        //2.添加UICollectionView，用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

//MARK:UIColloectionViewDataSource
extension PageContentView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //创建cel
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        //2.给cell设置内容
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.frame
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

//MARK 对外暴露的方法
extension PageContentView {

    func setupCurrentIndex(currentIndex : Int) {
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX , y: 0), animated: true)
        
    }
}
