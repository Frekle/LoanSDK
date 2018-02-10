//
//  ProdCalcView.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/4.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class ProdCalcView: UIView {
        
    var dataSource = [ProdData]()
    let picker = BaseTableView()
    fileprivate let contentView = UIView()
    
    var selectedCache = [0: 0]
    var hasSetSelectedRow = false
    var iSelectedTextColor = UIColor.white
    
    var confirmCallback: ((ProdData) -> Void)?
//    var selectedType: ProdData?
    
    required convenience init(dataSource: [ProdData]) {
        self.init(frame: CGRect.zero)
        self.dataSource = dataSource
        initUserInterface(dataSource: dataSource)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUserInterface(dataSource: [ProdData]) {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        addSubview(contentView)
        contentView.backgroundColor = UIColor.white
        contentView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(300)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.line
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(contentView).offset(42)
            make.height.equalTo(Screen.onePX)
        }
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.line
        contentView.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(lineView).offset(42)
            make.height.equalTo(Screen.onePX)
        }
        
        contentView.addSubview(picker)
        picker.dataSource = self
        picker.delegate   = self
        picker.snp.makeConstraints { make in
            make.top.equalTo(bottomLine)
            make.left.right.bottom.equalTo(contentView)
        }

        let prodNum = UILabel(title: "分期期数", titleColor: UIColor.dark, font: UIFont.size14)
        contentView.addSubview(prodNum)
        prodNum.snp.makeConstraints { (make) in
//            make.left.equalTo(contentView)
            make.centerX.equalTo(contentView).multipliedBy(0.25)
            make.width.equalTo(75)
            make.top.equalTo(lineView)
            make.bottom.equalTo(bottomLine)
        }
        
        let onePhaseMoney = UILabel(title: "每期应还", titleColor: UIColor.dark, font: UIFont.size14)
        contentView.addSubview(onePhaseMoney)
        onePhaseMoney.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.width.equalTo(75)
            make.top.equalTo(lineView)
            make.bottom.equalTo(bottomLine)
        }
        
        let dateLabel = UILabel(title: "每期还款日", titleColor: UIColor.dark, font: UIFont.size14)
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
//            make.right.equalTo(contentView)
            make.width.equalTo(75)
            make.centerX.equalTo(contentView).multipliedBy(1.75)
            make.top.equalTo(lineView)
            make.bottom.equalTo(bottomLine)
        }
        
        let button = UIButton(title: "确定", titleColor: UIColor.theme)
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.right.equalTo(contentView)
            make.width.equalTo(75)
            make.top.equalTo(contentView)
            make.bottom.equalTo(lineView)
        }
        button.addTarget(self, action: #selector(respondsToSureButton(_:)), for: .touchUpInside)

//        let cancelButton = UIButton(title: "取消", titleColor: UIColor.theme)
//        contentView.addSubview(cancelButton)
//        cancelButton.snp.makeConstraints { make in
//            make.left.equalTo(contentView)
//            make.width.equalTo(75)
//            make.top.equalTo(contentView)
//            make.bottom.equalTo(lineView)
//        }
//        cancelButton.addTarget(self, action: #selector(respondsToCancelButton), for: .touchUpInside)
    }
    
    @objc func respondsToSureButton(_ sender: UIButton) {
//        guard let selectedType = selectedType else {return}
        confirmCallback?(dataSource[0])
        removeFromSuperview()
    }
    
    @objc func respondsToCancelButton() {
        removeFromSuperview()
    }
    
    static func show(dataSource: [ProdData], callback: @escaping (ProdData) -> Void) {
        if let window = UIApplication.shared.keyWindow {
            let picker = ProdCalcView(dataSource: dataSource)
            picker.confirmCallback = callback
//            picker.selectedType = dataSource[0]
            window.addSubview(picker)
            picker.snp.makeConstraints({ (make) in
                make.edges.equalTo(window)
            })
            
            picker.setupDefaultSelectedRow()
        }
    }
    
    func setupDefaultSelectedRow() {
        
    }
}

extension ProdCalcView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.mm_reuseCell(indexPath) as ProdListCell
        cell.dataSource = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}
