//
//  HomeBannerCell.swift
//  UTOO
//
//  Created by Lenny on 16/10/27.
//  Copyright © 2016年 Lenny. All rights reserved.
//

import UIKit

class HomeBannerCell: BaseTableViewCell {
    
    var bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Scale.height(225)))
    
////    var backContentView = UIView()
//
//    var eventHandler: ((UIImageView, Int) -> Void)?
//
//    var parentViewController: UIViewController?
//
//    var itemClickHandler: ((_ index: Int) -> Void)?
//
////    var homeBannerList: [HomeBannerData]? {
////        didSet {
////            guard let homeBannerList = homeBannerList else{return}
////            loadData(homeBannerList)
////        }
////    }
    
    override func initUserInterface() {
        super.initUserInterface()
        
        bannerView.imageItems = ["banner1", "banner_2"]
        contentView.addSubview(bannerView)
        bannerView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
            make.height.equalTo(Scale.height(200))
        }
        
    }
}
