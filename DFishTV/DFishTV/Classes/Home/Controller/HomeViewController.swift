//
//  HomeViewController.swift
//  DFishTV
//
//  Created by 张海勇 on 2017/6/15.
//  Copyright © 2017年 张海勇. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController,PagetitleViewDelegate,PageContentViewDelegate {

    //MARK:block懒加载属性  在block中使用self，为了避免循环引用，需加上 [weak self] in
    lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width:kScreenW , height: kTitleViewH)
        let titles = ["推荐","手游","娱乐","游戏","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self

        return titleView
    }()
    
    lazy var pageContentView : PageContentView = {[weak self] in
    
        //1.确定内容的frame
        let pageContentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let pageContentFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH+kTitleViewH, width: kScreenW, height: pageContentH)
        
        //2.确定所有的字控制器
        var childVcs = [UIViewController]()
        for _ in 0...4 {
        
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let pageContentView = PageContentView(frame: pageContentFrame, childVcs: childVcs, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.orange
        //设置UI界面
        setupUI()
    }
}

// MARK --设置UI界面
extension HomeViewController{
    func setupUI() {
        
        //MARK：-当在有导航栏的控制器中添加UIScrollView时，系统会自动给UIScrollVIew添加64的内边距
        //0:不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
    
        //设置导航栏
        setupNavigationBar()
        
        //设置searchView
        let searchView = Bundle.main.loadNibNamed("SearchView", owner: self, options: nil)?.last as? SearchView
        searchView?.frame = CGRect(x: kScreenW/4, y: 9, width: kScreenW/2, height: 28)
        navigationItem.titleView = searchView
        
        //添加pageTitleView
        view.addSubview(pageTitleView)
        
        //添加pageContentView
        view.addSubview(pageContentView)
        
    }
    
    private func setupNavigationBar() {
        
        //设置左侧的item
        let btn = UIButton()
        btn.setImage(UIImage(named:"logo"), for: .normal)
        //根据图标自适应大小
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //设置右侧的item
        //历史按钮
        let size = CGSize(width: 30, height: 30)
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", highImageName: "viewHistoryIconHL", size: size)
        
        //游戏中心
        let gameCenterItem = UIBarButtonItem(imageName: "home_newGameicon", highImageName: "home_newGameicon_clicked", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,gameCenterItem]
    }
}

//MARK: PagetitleViewDelegate
extension HomeViewController {

    func pageTitleView(titleView: PageTitleView, selectedIndex : Int) {
        
        pageContentView.setupCurrentIndex(currentIndex: selectedIndex)
    }
}

//MARK 遵循PageContentViewDelegate协议
extension HomeViewController {

    func pageContent(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleView.changeTitlesWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
