//
//  RecommendViewController.swift
//  DFishTV
//
//  Created by 张海勇 on 2017/6/22.
//  Copyright © 2017年 张海勇. All rights reserved.
//



import UIKit

private let contentCellID =  "contentCellID"
private let contentHeaderID =  "contentHeaderID"
private let kItemMargin : CGFloat = 5
private let kHeaderViewH : CGFloat = 45
private let kItemSize : CGFloat = (kScreenW-15.0)/2.0
class RecommendViewController: UIViewController {

    //MARK --懒加载UICollectionView
    lazy var collectionView : UICollectionView = {
    
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        //该方法也可以设置itemSize
        layout.itemSize = CGSize(width: kItemSize, height: kItemSize*4/5)
        //cell的最小行间距
        layout.minimumLineSpacing = 0
        //设置同一列中间隔的cell最小间距
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        ////设置headerView的尺寸大小
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //自动调整子控件与父控件中间的位置，宽高
//        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: contentCellID)
        //注册headerView
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: contentHeaderID)
        return collectionView
    }()
    
    //MARK:系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建UI界面
        setupUI()
    }
}

extension RecommendViewController {

    func setupUI() {
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
}

extension RecommendViewController : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  section == 0 {
        
            return 8
        }
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: contentHeaderID, for: indexPath)
        return headerView
    }
    
    
}

