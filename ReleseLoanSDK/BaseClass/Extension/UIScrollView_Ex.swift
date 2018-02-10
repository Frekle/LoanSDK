//
//  UIScrollView_Ex.swift
//  UTOO
//
//  Created by 王亮 on 2016/10/29.
//  Copyright © 2016年 Lenny. All rights reserved.
//

import Foundation
import MJRefresh

//没有商品
var k_noGood = "noGood"

//private var xoAssociationKey: UInt8 = 0

extension UIScrollView {

    /** 上拉刷新控件 */
    open var noData: Bool? {
        get {
            return self.noData
        }
        set {
            if let isNoData = newValue {
                switch isNoData {
                case true:
                    self.showNoDataView()
                default:
                    self.removeNoDataView()
                }
            }
        }
    }
    
    // 暂无数据
    func showNoDataView() {
        let nodataImageView = UIImageView(name: "nodata_placeholder")
        self.addSubview(nodataImageView)
        objc_setAssociatedObject(self, &k_noGood, nodataImageView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        nodataImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(50)
        }
    }
    
    // 有数据
    func removeNoDataView() {
        if let view = objc_getAssociatedObject(self, &k_noGood) as? UIView {
            view.removeFromSuperview()
        }
    }
    
    //添加头刷新
    func addHeadRefresh(_ block:(()->())?) {
        
        self.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { 
            
            if block != nil {
                block!()
            }
        })
    }
    
    func beginHeadRefresh() {
        self.mj_header.beginRefreshing()
    }
    func endHeadRefresh() {
        self.mj_header.endRefreshing()
    }
    //添加尾刷新
    func addFootRefresh(_ block:(()->())?) {
        
        self.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: { 
            
            if block != nil {
                block!()
            }
        })
    }
    func beginFootRefresh() {
        self.mj_footer.beginRefreshing()
    }
    func endFootRefresh() {
        self.mj_footer.endRefreshing()
    }
}

extension UICollectionView {
    /**
     用这个方法需要注册T时，需要把identifier定义成和T的类名相同的字符串，否则会崩溃
     待完善
     */
    func mm_dequeseCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        let reuseIdentifier = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        return self.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
    }
    
    convenience init(color: UIColor = UIColor.backGray) {
        let layout = UICollectionViewFlowLayout()
        self.init(frame: CGRect.zero, collectionViewLayout: layout)
        self.backgroundColor = color
    }
}
