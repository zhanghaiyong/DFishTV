//
//  RecommendViewController.swift
//  DFishTV
//
//  Created by 张海勇 on 2017/6/22.
//  Copyright © 2017年 张海勇. All rights reserved.
//



import UIKit
import Alamofire

private let contentNormalCellID =  "contentNormalCellID"
private let contentPrettyCellID =  "contentPrettyCellID"
private let contentHeaderID =  "contentHeaderID"
private let kItemMargin : CGFloat = 5
private let kHeaderViewH : CGFloat = 46
private let kItemW : CGFloat = (kScreenW-kItemMargin*3)/2.0
private let kItemNormalH : CGFloat = kItemW*4/5
private let kItemPrettyH : CGFloat = kItemW
class RecommendViewController: UIViewController {

    
    lazy var recommendVM : RecommendModelView = RecommendModelView()
    
    //MARK --懒加载UICollectionView
    lazy var collectionView : UICollectionView = {
    
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        //该方法也可以设置itemSize
//        layout.itemSize = CGSize(width: kItemW, height: kItemNormalH)
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
        collectionView.delegate = self
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: contentNormalCellID)
                collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: contentPrettyCellID)
        //注册headerView
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: contentHeaderID)
        return collectionView
    }()
    
    //MARK:系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        //创建UI界面
        setupUI()

        //请求数据
        loadData()
    }
}

//MARK:请求数据
extension RecommendViewController {

    //最热数据
    func loadData() {
    
        self.recommendVM.requestDataMethod { 
            
            self.collectionView.reloadData()
            
        }
    }
}

extension RecommendViewController {

    func setupUI() {
        
        view.addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-64-49-40)
    }
}

extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.recommendVM.dataSurce.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = self.recommendVM.dataSurce[section]
        return group.anchors.count
    }
    
    //返回item的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
        
            return CGSize(width: kItemW, height: kItemPrettyH)
        }
        return CGSize(width: kItemW, height: kItemNormalH)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1.取出模型对象
        let group = self.recommendVM.dataSurce[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentPrettyCellID, for: indexPath) as! CollectionPrettyCell
            cell.anchor = anchor as? AnchorModel
            return cell

        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentNormalCellID, for: indexPath) as! CollectionNormalCell
            cell.anchor = anchor as? AnchorModel
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let group = self.recommendVM.dataSurce[indexPath.section]
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: contentHeaderID, for: indexPath) as! CollectionHeaderView
        headerView.group = group
        return headerView
    }
}


