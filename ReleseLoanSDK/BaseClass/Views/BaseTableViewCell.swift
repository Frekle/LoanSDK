//
//  BaseTableViewCell.swift
//  UTOO
//
//  Created by Lenny on 16/9/23.
//  Copyright © 2016年 Lenny. All rights reserved.
//

import UIKit
import ObjectMapper

//tableViewCell 的公共类
class BaseTableViewCell: UITableViewCell {
    
    let line = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        initUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUserInterface() {
        
        line.backgroundColor = UIColor.line
        contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(contentView)
            make.height.equalTo(Screen.onePX)
        }
    }
}
