//
//  CompanyInfoViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/29.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class CompanyInfoViewController: BaseViewController {

    let leftInfo = ["公司名称", "公司电话", "职业", "行业", "职位", "公司地址", ""]
    var details = ["", "", "请选择", "请选择", "请选择", "请选择"]
    var workList = [TypeModel]()
    var industryList = [TypeModel]()
    var possitionList = [TypeModel]()
    var selectedWork: TypeModel?
    var selectedIndustry: TypeModel?
    var selectedPossition: TypeModel?
    var unitNameTF: UITextField?
    var unitTelTF: UITextField?
    var addressTF: UITextField?
    var province: String?
    var city: String?
    var area: String?
    
    var commitCallback: ((Bool) -> ())?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        title = "公司信息"
        
        let commitButton = UIButton.bottomButton(title: "提交")
        commitButton.addTarget(self, action: #selector(respondToCommitButton), for: .touchUpInside)
        view.addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(view)
            make.height.equalTo(50)
        }
        
        let tableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(commitButton.snp.top)
        }
        
    }
    
    override func initDataSource() {
        super.initDataSource()
        CertificationModel.checkList(typeNames: ["work_job", "industry", "position_level"]) { (data) in
            guard let work = data.work_job else {return}
            self.workList = work
            guard let industry = data.industry else{return}
            self.industryList = industry
            guard let position = data.position_level else{return}
            self.possitionList = position
        }
    }

    @objc func respondToCommitButton() {
        guard let unitName = unitNameTF?.text else{return}
        guard let unitTel = unitTelTF?.text else{return}
        guard let address = addressTF?.text else{return}
        guard let industry = selectedIndustry else{return}
        guard let workpost = selectedWork else{return}
        guard let workJob = selectedPossition else{return}
        guard let prov = province, let city = city, let area = area else{return}
        CertificationModel.saveWorkInfo(unitName: unitName, unitTel: unitTel, industry: industry.valName, workPost: workpost.valName, workJob: workJob.valName, unitProv: prov, unitCity: city, unitArea: area, unitAddr: address, callback: {
            self.commitCallback?(true)
            self.navigationController?.popViewController(animated: true)
        })
    }
}

extension CompanyInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 6:
            let cell = tableView.mm_dequeueStaticCell(indexPath) as TextfieldCell
            cell.verifyTextfield.placeholder = "请填写详细地址，不少于5个字"
            addressTF = cell.verifyTextfield
            return cell
        default:
            let cell = tableView.mm_reuseCell(indexPath) as ScanBankCardCell
            cell.commonLabel.text = leftInfo[indexPath.row]
            if indexPath.row.isIn(0, 1) {
                cell.type = .rightField
                switch indexPath.row {
                case 1:
                    cell.inputTextfield.attributedPlaceholder = NSAttributedString(string: "请输入(选填)", attributes: [NSAttributedStringKey.foregroundColor:UIColor.lightGray])
                    unitTelTF = cell.inputTextfield
                default:
                    unitNameTF = cell.inputTextfield
                }
            } else {
                cell.detailLabel.text = details[indexPath.row]
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        switch indexPath.row {
        case 2:
            JobChoosePicker.show(dataSource: workList, chooseCallback: { type in
                self.selectedWork = type
                self.details[indexPath.row] = type.valName
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        case 3:
            CommonPickerView.show(dataSource: industryList, callback: { type in
                self.selectedIndustry = type
                self.details[indexPath.row] = type.valName
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        case 4:
            JobChoosePicker.show(dataSource: possitionList, chooseCallback: { type in
                self.selectedPossition = type
                self.details[indexPath.row] = type.valName
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        case 5:
            CityPickerView().show(didTapSureButton: { prov, city, area in
                self.province = prov
                self.city = city
                self.area = area
                self.details[indexPath.row] = prov + " " + city + " " + area
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        default:
            break
        }
    }
}

