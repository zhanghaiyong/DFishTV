//
//  PageTitleView.swift
//  DFishTV
//
//  Created by 张海勇 on 2017/6/15.
//  Copyright © 2017年 张海勇. All rights reserved.
//

import UIKit

protocol PagetitleViewDelegate : class {
    
    func pageTitleView(titleView : PageTitleView,selectedIndex : Int);
    
}

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {

  //MARK:-定义属性
     var titles : [String]
    
    var currentIndex : Int = 0
    
    var titleLabels : [UILabel] = [UILabel]()
    
    weak var delegate : PagetitleViewDelegate?
    
    
  //MARK:-懒加载属性 闭包创建
    lazy var scrollView : UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var scrollLine : UIView = {
    
     let scrollLine = UIView()
     scrollLine.backgroundColor = UIColor.orange
     return scrollLine
    }()
    
  //MARK:-自定义构造函数
    init(frame: CGRect,titles:[String]) {
        
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//MAKR：-设置UI界面
extension PageTitleView {

    func setupUI() {
    
        //1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加title对应的label
        setupTitleLabel()
        
        //3.设置底线和滚动的滑线
        setupBottomLineAndScrollLine()
    }
    
    func setupTitleLabel() {
        
        //0.确定label的一些frame确定的值
        let labelW : CGFloat = frame.width/CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            //创建label
            let label = UILabel()
            //设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            //3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //4.将创建的label添加到scrollView上
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.给label添加手势
            label.isUserInteractionEnabled = true
            let tpGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGue:)))
            label.addGestureRecognizer(tpGes)
        }
    }
    
    func setupBottomLineAndScrollLine(){
    
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine
        //2.1 获取第一个label
        guard let firstLabel = titleLabels.first else {
            return
        }
        //第一个label字体颜色为橘色
        firstLabel.textColor = UIColor.orange
        //2.2设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
}

//MARK: 监听label的点击
extension PageTitleView {
    //事件监听函数，需要在前面加一个@objc
    @objc func titleLabelClick(tapGue: UITapGestureRecognizer) {
    
        //1.获取当前label的下标值
        guard let currentLabel = tapGue.view as? UILabel else {return}
        
        //2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //3.切换文字颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkText
        
        //4.保存执行的下标值
        currentIndex = currentLabel.tag
        
        //5.滚动条发生变化
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentLabel.tag)
        print("----")
    }
}
