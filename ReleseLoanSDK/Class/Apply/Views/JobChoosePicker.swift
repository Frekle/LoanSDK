//
//  JobChoosePicker.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/19.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class JobChoosePicker: UIView {

    var dataSource = [TypeModel]()
    var chooseCallback: ((TypeModel) -> ())?
    var selected: TypeModel?
    
    required convenience init(dataSource: [TypeModel]) {
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
    
    func initUserInterface(dataSource: [TypeModel]) {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(responsedToBackTaped))
        tap.delegate = self
        addGestureRecognizer(tap)
        
        let commitButton = UIButton.bottomButton(title: "提交")
        commitButton.addTarget(self, action: #selector(responsedToCommitButton), for: .touchUpInside)
        addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(50)
        }
        
        let tableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.bottom.equalTo(commitButton.snp.top).offset(-20)
            make.left.right.equalTo(self)
            make.height.equalTo(dataSource.count * 44)
        }
    }
    
    @objc func responsedToCommitButton() {
        guard let selected = selected else {
            return self.showHUD("请选择行业")
        }
        chooseCallback?(selected)
        removeFromSuperview()
    }
    
    @objc func responsedToBackTaped() {
        removeFromSuperview()
    }

    static func show(dataSource: [TypeModel], chooseCallback: @escaping (TypeModel) -> ()) {
        if let window = UIApplication.shared.keyWindow {
            let picker = JobChoosePicker(dataSource: dataSource)
            picker.chooseCallback = chooseCallback
            window.addSubview(picker)
            picker.snp.makeConstraints({ (make) in
                make.edges.equalTo(window)
            })
        }
    }
}

extension JobChoosePicker: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isKind(of: JobChoosePicker.self))! {
            return true
        } else {
            return false
        }
    }
}

extension JobChoosePicker: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.mm_dequeueStaticCell(indexPath) as CommonTextCell
        cell.commonLabel.text = dataSource[indexPath.row].valName
        cell.rightArrow.isHidden = true
        cell.selectionStyle = UITableViewCellSelectionStyle.default
        cell.commonLabel.snp.remakeConstraints { (make) in
            make.center.equalTo(cell.contentView)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = dataSource[indexPath.row]
    }
}
