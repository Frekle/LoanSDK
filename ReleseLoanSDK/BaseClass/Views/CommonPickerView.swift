//
//  CommonPickerView.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/19.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class CommonPickerView: UIView {

    var dataSource = [TypeModel]()
    let picker = UIPickerView()
    fileprivate let contentView = UIView()
    
    var selectedCache = [0: 0]
    var hasSetSelectedRow = false
    var iSelectedTextColor = UIColor.white
    
    var confirmCallback: ((TypeModel) -> Void)?
    var selectedType: TypeModel?
    
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
        
        contentView.addSubview(picker)
        picker.dataSource = self
        picker.delegate   = self
        picker.snp.makeConstraints { make in
            make.top.equalTo(lineView)
            make.left.right.bottom.equalTo(contentView)
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
        
        let cancelButton = UIButton(title: "取消", titleColor: UIColor.theme)
        contentView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.left.equalTo(contentView)
            make.width.equalTo(75)
            make.top.equalTo(contentView)
            make.bottom.equalTo(lineView)
        }
        cancelButton.addTarget(self, action: #selector(respondsToCancelButton), for: .touchUpInside)
    }
    
    @objc func respondsToSureButton(_ sender: UIButton) {
        guard let selectedType = selectedType else {return}
        confirmCallback?(selectedType)
        removeFromSuperview()
    }
    
    @objc func respondsToCancelButton() {
        removeFromSuperview()
    }
    
    static func show(dataSource: [TypeModel], callback: @escaping (TypeModel) -> Void) {
        if let window = UIApplication.shared.keyWindow {
            let picker = CommonPickerView(dataSource: dataSource)
            picker.confirmCallback = callback
            picker.selectedType = dataSource[0]
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

extension CommonPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row].valName
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if hasSetSelectedRow == false {
            if let coloms = pickerView.subviews.first {
                if let subviewCache = coloms.value(forKey: "subviewCache") as? Array<AnyObject> {
                    if let middleContainerView = subviewCache.first?.value(forKey: "middleContainerView") as? UIView {
                        middleContainerView.backgroundColor = UIColor.gray
                        hasSetSelectedRow = true
                    }
                }
            }
        }
        
        
        var pickerLabel = view as? UILabel
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.adjustsFontSizeToFitWidth = true
            pickerLabel?.textAlignment = .center
            pickerLabel?.font = UIFont.size15
            let selected = selectedCache[component]
            let color = selected == row ? self.iSelectedTextColor : UIColor.placeholder
            pickerLabel?.textColor = color
        }
        pickerLabel?.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        return pickerLabel!
    }
    
    //
    //    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    //
    //    }
}


// MARK: - UIPickerViewDelegate
extension CommonPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCache[component] = row
        pickerView.reloadComponent(component)
        selectedType = dataSource[row]
    }
}
