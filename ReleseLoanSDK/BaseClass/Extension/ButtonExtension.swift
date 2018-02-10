//
//  ButtonExtension.swift
//  UTOO
//
//  Created by Frekle on 2017/2/16.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import UIKit

extension UIButton {
    
//    convenience init(title: String = "", titleColor: UIColor, font: UIFont) {
//        self.init()
//        self.text = title
//        self.textColor = titleColor
//        self.font = font
//    }
    
    convenience init(title: String = "", titleColor: UIColor = UIColor.dark, font: UIFont = UIFont.size14) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
    }
    
    convenience init(image: String = "") {
        self.init()
        self.setImage(UIImage(named: image), for: .normal)
    }
    
    func setAttributeString(str: String, border: Int, font: UIFont) {
        let nameStr:NSMutableAttributedString = NSMutableAttributedString(string: str)
        let range = NSMakeRange(0, border)
        nameStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.lightGray, range: range)
        let range2 = NSMakeRange(border, str.count-border)
        nameStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(29, 68, 255), range: range2)
        nameStr.addAttribute(NSAttributedStringKey.font, value: font, range: NSMakeRange(0, str.count))
        setAttributedTitle(nameStr, for: .normal)
    }
    
    // 让uibutton的图片和文字上下垂直，注意图片宽度要大于文字宽度
    func verticalImageAndTitle(_ spacing: CGFloat) {
        let imageSize = imageView?.image?.size
        let titleSize = titleLabel?.frame.size
        let textSize = (titleLabel?.text ?? "").stringSize(font: UIFont.size14)
        let imageHeight = imageSize?.height ?? 0
        let imageWidth = imageSize?.width ?? 0
        let titleHeight = titleSize?.height ?? 0
        var titleWidth = titleSize?.width ?? 0
        let frameSize = CGSize(width: ceil(textSize.width), height: ceil(textSize.height))
        if (titleWidth + 0.5) < frameSize.width {
            titleWidth = frameSize.width
        }
        
        
        let totalHeight = imageHeight + titleHeight + spacing
        imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageHeight), 0.0, 0.0, -titleWidth)
        titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -(totalHeight - titleHeight), 0)
    }
    
    static func themeButton(title: String) -> UIButton {
        let loginBtn = UIButton(title: title, titleColor: UIColor.white)
        loginBtn.titleLabel?.font = UIFont.size18
        loginBtn.layer.cornerRadius = 25
        
        let grandientlayer = CAGradientLayer(bounds: CGRect.init(x: 0, y: 0, width: Screen.width - 40, height: 50))
        loginBtn.layer.insertSublayer(grandientlayer, at: 0)
        loginBtn.clipsToBounds = true
        
        return loginBtn
    }
    
    static func bottomButton(title: String) -> UIButton {
        let loginBtn = UIButton(title: title, titleColor: UIColor.white)
        loginBtn.titleLabel?.font = UIFont.size18
        
        let grandientlayer = CAGradientLayer(bounds: CGRect.init(x: 0, y: 0, width: Screen.width, height: 50))
        loginBtn.layer.insertSublayer(grandientlayer, at: 0)
        loginBtn.clipsToBounds = true
        
        return loginBtn
    }
}

class VerticalButton: UIButton {
    // 重写图片的frame
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageWidth = contentRect.size.width
        let imageHeight = contentRect.size.height * 0.5
        return CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
    }
    
    // 重写文字的farme
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleY = contentRect.size.height * 0.5
        let titleWidth = contentRect.size.width;
        let titleHeight = contentRect.size.height - titleY
        return CGRect.init(x: 0, y: titleY, width: titleWidth, height: titleHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView?.contentMode = .center
        self.titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func button(title: String, image: String) -> VerticalButton {
        let verticalButton = VerticalButton(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        verticalButton.setTitle(title, for: .normal)
        verticalButton.setTitleColor(UIColor.darkText, for: .normal)
        verticalButton.setImage(UIImage(named: image), for: .normal)
        verticalButton.titleLabel?.font = UIFont.size14
        return verticalButton
    }
}

class VerticallyButton: UIButton {
    
    let buttonLabel = UILabel(title: "", titleColor: UIColor.darkText, font: UIFont.size14)
    
    static func commonButton(title: String, image: String) -> VerticallyButton {
        let button = VerticallyButton()
        button.setImage(UIImage(named: image), for: .normal)
        button.buttonLabel.text = title
        return button
    }
    
    // 重写图片的frame
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageWidth = contentRect.size.width
        let imageHeight = contentRect.size.height * 0.5
        return CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUserInterface() {
        self.imageView?.clipsToBounds = false
        self.imageView?.contentMode = .center
        addSubview(buttonLabel)
        buttonLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
}
