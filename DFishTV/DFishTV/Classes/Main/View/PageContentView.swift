//
//  PageContentView.swift
//  DFishTV
//
//  Created by 张海勇 on 2017/6/16.
//  Copyright © 2017年 张海勇. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    
    func pageContent(progress : CGFloat,sourceIndex : Int,targetIndex : Int)
}

private let contentCellID = "contentCellID"

class PageContentView: UIView {
    
    var childVcs : [UIViewController]
    weak var parentViewController : UIViewController?
    var startOffset : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    //当点击label的时候，禁止UIScrollView滚动
    var isStopScroll : Bool = false
    
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
        collectionView.delegate = self
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

//MARK:UICollectionDelegate
extension PageContentView : UICollectionViewDelegate {

    //开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        startOffset = scrollView.contentOffset.x
        //当拖拽的时候，不禁止UIScrollView滚动
        isStopScroll = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isStopScroll {
        
            return;
        }
        
        print("滚动了")
        //初始化需要获取的值
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //当前偏移量
        let currentOffsetX = scrollView.contentOffset.x
        
        if currentOffsetX > startOffset { //左滑
        
            progress = currentOffsetX / scrollView.bounds.width - floor(currentOffsetX / scrollView.bounds.width)
            sourceIndex = Int(currentOffsetX/scrollView.bounds.width)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
            
                targetIndex = childVcs.count-1
            }
            if currentOffsetX - startOffset == scrollView.bounds.width {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else {  //右滑
        
            progress = 1 - (currentOffsetX / scrollView.bounds.width - floor(currentOffsetX / scrollView.bounds.width))
            targetIndex = Int(currentOffsetX/scrollView.bounds.width)
            sourceIndex = targetIndex + 1
            if sourceIndex > childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
//            if startOffset - currentOffsetX == scrollView.bounds.width {
//                progress = 1
//                sourceIndex = targetIndex
//            }
        }
        
        print("progress = \(progress)   sourceIndex = \(sourceIndex)  targetIndex = \(targetIndex)")
        
        delegate?.pageContent(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}

//MARK 对外暴露的方法前面不能加private
extension PageContentView {
    
    func setupCurrentIndex(currentIndex : Int) {
        
        isStopScroll = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX , y: 0), animated: true)
        
    }
}
