//
//  BorrowAmountViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/14.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class BorrowAmountViewController: BaseViewController {

    let titles = ["产品类型", "借款金额", "还款期限", "分期用途", "信用卡认证"]
    var details = ["", "", "12个月", "日常消费", "未认证"]
    var insts = [String]()
    var loanType = [TypeModel]()
    var inst = "12"
//    var goodsNum = "10000"
    var selectedFeeNo = ""
    var goodsNumTF: UITextField?
    
    var faceIdResultData: FaceIdResultData?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        title = "申请借款"
        
        let tableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        let nextStepButton = UIButton.bottomButton(title: "下一步")
        nextStepButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        view.addSubview(nextStepButton)
        nextStepButton.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(50)
        }
    }
    
    override func initDataSource() {
        super.initDataSource()
        CertificationModel.instNum { insts in
            self.insts = insts
        }
        CertificationModel.checkList(typeNames: ["loan_use"]) { (data) in
            guard let loanType = data.loan_use else{return}
            self.loanType = loanType
        }
    }
    
    @objc func nextStep() {
        guard let goodsAmount = goodsNumTF?.text else {return}
        guard Int(goodsAmount) ?? 0 < 50000 else{return view.showHUD("最高额度为50000")}
        CertificationModel.prodCalc(instNum: inst, goodsAmt: goodsAmount, payAmt: "0", feeNos: selectedFeeNo) { (data) in
            ProdCalcView.show(dataSource: data, callback: { prod in
                let mthRepay = String(format: "%.2f", prod.mthAmt)
                self.saveProd(mthRepay: mthRepay, fstRepay: prod.busiDate)
            })
        }
    }
    
    func saveProd(mthRepay: String, fstRepay: String) {
        CertificationModel.saveProdTrial(inst: inst, loanAmt: "10000", mthRepay: mthRepay, fstRepay: fstRepay, feeList: [selectedFeeNo]) { string in
            UserInfo.shared().loanNo = string
            let certifyDataVC = CertifiyDataViewController()
            certifyDataVC.faceIdResultData = self.faceIdResultData
            self.navigationController?.pushViewController(certifyDataVC, animated: true)
        }
    }
}

extension BorrowAmountViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.mm_reuseCell(indexPath) as ApplyStepsCell
            cell.stepsImageView.image = UIImage.init(named: "pic_buzhou2")
            return cell
        case 2:
            let cell = tableView.mm_reuseCell(indexPath) as BorrowAmountCell
            goodsNumTF = cell.inputTF
            return cell
        default:
            let cell = tableView.mm_reuseCell(indexPath) as ScanBankCardCell
            cell.commonLabel.text = titles[indexPath.row - 1]
            if indexPath.row == 1 {
                cell.type = .cardNumber
                cell.scanButton.isHidden = true
                cell.cardNumberTextfield.placeholder = "信用卡极速分期（特殊）"
                cell.cardNumberTextfield.isEnabled = false
            } else {
                cell.detailLabel.text = details[indexPath.row - 1]
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 3:
            var types = [TypeModel]()
            insts.forEach({ (str) in
                let type = TypeModel()
                type.valName = str
                types.append(type)
            })
            CommonPickerView.show(dataSource: types, callback: { (type) in
                self.details[indexPath.row - 1] = type.valName + "个月"
                tableView.reloadData()
            })
        case 4:
            CommonPickerView.show(dataSource: loanType, callback: { (type) in
                self.details[indexPath.row - 1] = type.valName
                self.selectedFeeNo = type.valName
                tableView.reloadData()
            })
        case 5:
            navigationController?.pushViewController(CreditCardViewController(), animated: true)
        default:
            break
        }
    }
}



