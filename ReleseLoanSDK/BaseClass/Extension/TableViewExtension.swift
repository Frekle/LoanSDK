//
//  TableViewExtension.swift
//  UTOO
//
//  Created by Frekle on 2017/2/9.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    /**
     弹出一个静态的cell，无须注册重用，例如:
     let cell: GrayLineTableViewCell = tableView.mm_dequeueStaticCell(indexPath)
     即可返回一个类型为GrayLineTableViewCell的对象
     
     - parameter indexPath: cell对应的indexPath
     
     - returns: 该indexPath对应的cell
     */
    func mm_dequeueStaticCell<T: UITableViewCell>(_ indexPath: IndexPath) -> T {
        let reuseIdentifier = "\(T.description()) - section:\(indexPath.section),row:\(indexPath.row)"
        if let cell = self.dequeueReusableCell(withIdentifier: reuseIdentifier) as? T {
            return cell
        }else {
            let cell = T(style: .default, reuseIdentifier: reuseIdentifier)
            return cell
        }
    }
    
    func mm_dequeueStaticHeaderFooterView<T: UITableViewHeaderFooterView>(_ section: Int, isHeader: Bool) -> T {
        let reuseIdentifier = "\(T.description()) - \(isHeader ? "Header" : "Footer") - section:\(section)"
        if let header = self.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? T {
            return header
        } else {
            let header = T(reuseIdentifier: reuseIdentifier)
            return header
        }
    }
    
    func mm_dequeueStaticHeaderView<T: UITableViewHeaderFooterView>(_ section: Int) -> T {
        let header: T = mm_dequeueStaticHeaderFooterView(section, isHeader: true)
        return header
    }
    
    func mm_dequeueStaticFooterView<T: UITableViewHeaderFooterView>(_ section: Int) -> T {
        let footer: T = mm_dequeueStaticHeaderFooterView(section, isHeader: false)
        return footer
    }
    
    /** 可重用的cell创建方法 */
    func mm_reuseCell<T: UITableViewCell>(_ indexPath: IndexPath) -> T {
        let reuseIdentifier = "\(T.description())"
        if let cell = self.dequeueReusableCell(withIdentifier: reuseIdentifier) as? T {
            return cell
        } else {
            let cell = T(style: .default, reuseIdentifier: reuseIdentifier)
            return cell
        }
    }
    
    /** 可重用的section header */
    func mm_reuseSectionHeader<T: UIView>() -> T {
        let reuseIdentifier = "\(T.description())"
        if let sectionView = self.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? T {
            return sectionView
        } else {
            let sectionView = T()
            return sectionView
        }
    }
    
    func mm_bindWith(_ viewController: UITableViewDelegate & UITableViewDataSource, topOffset: CGFloat = Screen.navBarHeight, bottomOffset: CGFloat = 0) {
        if let viewController = viewController as? UIViewController {
            viewController.view.addSubview(self)
            snp.makeConstraints { make in
                make.left.right.equalTo(viewController.view)
                make.top.equalTo(viewController.view).offset(topOffset)
                make.bottom.equalTo(viewController.view).offset(bottomOffset)
            }
        }
        delegate   = viewController
        dataSource = viewController
        keyboardDismissMode = .onDrag
        showsVerticalScrollIndicator = false
    }
    
    func setHorizontalSeparatorInsetZero() {
        separatorInset = UIEdgeInsetsMake(separatorInset.top, 0, separatorInset.bottom, 0)
        if #available(iOS 8.0, *) {
            layoutMargins  = UIEdgeInsetsMake(layoutMargins.top, 0, layoutMargins.bottom, 0)
        }
    }
    
    
}
