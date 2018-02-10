//
//  CityPickerView.swift
//  HomerEU
//
//  Created by Mango on 16/7/21.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

import FMDB

class CityPickerView: UIView {

    let picker = UIPickerView()
    fileprivate let contentView = UIView()
    var didTapSureButton: ((_ prov: String, _ city: String, _ area: String) -> Void)?
    
    lazy var cityText: String = self.getCityText()
    
    // MARK: - data
    fileprivate let db: FMDatabase = {
        var path = Bundle.main.path(forResource: "provinces", ofType: "db")
        return FMDatabase(path : path)
    }()
    
    fileprivate lazy var provinces: [Province] = {
        var provinces = [Province]()
        self.dbExecute {
            if let result = try? self.db.executeQuery("SELECT * FROM 't_address_province'", values: []) {
                while result.next() {
                    provinces.append(Province(result: result))
                }
            }
        }
        return provinces
    }()
    
    fileprivate lazy var citys: [City] = {
        if self.provinces.count > 0 {
            return self.getCities(self.provinces[0])
        }
        return []
    }()
    
    fileprivate lazy var towns: [Town] = {
        if self.citys.count > 0 {
            return self.getTowns(self.citys[0])
        }
        return []
    }()
    
    override init(frame: CGRect) {
        super.init(frame: Screen.bounds)
        initUserInterface()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initUserInterface() {
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
    
    override func willMove(toSuperview newSuperview: UIView?) {
        let selectedProvinceIndex = picker.selectedRow(inComponent: 0)
        citys = getCities(provinces[selectedProvinceIndex])
        picker.reloadComponent(1)
        let selectedCityIndex = picker.selectedRow(inComponent: 1)
        towns = getTowns(citys[selectedCityIndex])
        picker.reloadComponent(2)
    }
    
    fileprivate func getCityText() -> String {
        let provinceText = provinces[picker.selectedRow(inComponent: 0)].name ?? ""
        let cityText     = citys[picker.selectedRow(inComponent: 1)].name ?? ""
        let townText     = towns[picker.selectedRow(inComponent: 2)].name ?? ""
        return provinceText + " " + cityText + " " + townText
    }
    
    @objc func respondsToSureButton(_ sender: UIButton) {
        let provinceText = provinces[picker.selectedRow(inComponent: 0)].name ?? ""
        let cityText     = citys[picker.selectedRow(inComponent: 1)].name ?? ""
        let townText     = towns[picker.selectedRow(inComponent: 2)].name ?? ""
        didTapSureButton?(provinceText, cityText, townText)
        self.removeFromSuperview()
    }
    
    @objc func respondsToCancelButton() {
        removeFromSuperview()
    }
    
    func show(didTapSureButton: @escaping (_ prov: String, _ city: String, _ area: String) -> Void) {
        UIApplication.shared.keyWindow?.addSubview(self)
        self.didTapSureButton = didTapSureButton
    }
    
    func reloadAllComponents() {
        picker.reloadAllComponents()
    }
}

extension CityPickerView {
    
    fileprivate struct Province {
        var code: String?
        var name: String?
        var id: Int?
        init(result: FMResultSet) {
            code = result.string(forColumn: "code")
            name = result.string(forColumn: "name")
            id   = Int(result.int(forColumn: "id"))
        }
    }

    fileprivate struct City {
        var code: String?
        var name: String?
        var id: Int?
        init(result: FMResultSet) {
            code = result.string(forColumn: "code")
            name = result.string(forColumn: "name")
            id   = Int(result.int(forColumn: "id"))
        }
    }
    
    fileprivate struct Town {
        var code: String?
        var name: String?
        var id: Int?
        init(result: FMResultSet) {
            code = result.string(forColumn: "code")
            name = result.string(forColumn: "name")
            id   = Int(result.int(forColumn: "id"))
        }
    }
    
    fileprivate func dbExecute( _ closure: () -> Void) {
        if db.open() {
            closure()
        }
        db.close()
    }
    
    
    fileprivate func getCities(_ province: Province) -> [City] {
        var cities = [City]()
        dbExecute {
            if let result = try? db.executeQuery("SELECT * FROM t_address_city WHERE provinceCode = ?", values: [province.code ?? ""]) {
                while result.next() {
                    cities.append(City(result: result))
                }
            }
        }
        return cities
    }
    
    fileprivate func getTowns(_ city: City) -> [Town] {
        var towns = [Town]()
        dbExecute {
            if let result = try? db.executeQuery("SELECT * FROM t_address_town WHERE cityCode = ?", values: [city.code ?? ""]) {
                while result.next() {
                    towns.append(Town(result: result))
                }
            }
        }
        return towns
    }
    
    func select(_ province: String, city: String, town: String) {

        for (index, tempProvince) in provinces.enumerated() {
            if tempProvince.name == province {
                picker.selectRow(index, inComponent: 0, animated: false)
                citys = getCities(tempProvince)
                break
            }
        }
        for (index, tempCity) in citys.enumerated() {
            if tempCity.name == city {
                picker.selectRow(index, inComponent: 1, animated: false)
                towns = getTowns(tempCity)
                break
            }
        }
        for (index, tempTown) in towns.enumerated() {
            if tempTown.name == town {
                picker.selectRow(index, inComponent: 2, animated: false)
                break
            }
        }
        cityText = self.getCityText()
    }
}
// MARK: - UIPickerViewDataSource
extension CityPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return provinces.count
        case 1:
            return citys.count
        case 2:
            return towns.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return provinces[row].name
        case 1:
            return citys[row].name
        case 2:
            return towns[row].name
        default:
            return nil
        }
    }
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        
//    }
}


// MARK: - UIPickerViewDelegate
extension CityPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            citys = getCities(provinces[row])
            picker.reloadComponent(1)
            let selectedCityIndex = pickerView.selectedRow(inComponent: 1)
            towns = getTowns(citys[selectedCityIndex])
            picker.reloadComponent(2)
        case 1:
            towns = getTowns(citys[row])
            picker.reloadComponent(2)
        default:
            break
        }
        cityText = self.getCityText()
    }
}
