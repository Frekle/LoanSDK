//
//  CALayer+extension.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/14.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    convenience init(bounds: CGRect) {
        self.init()
        let TColor = UIColor.rgb(251, 80, 8)
        let BColor = UIColor.rgb(253, 125, 8)
        let gradientColors: [CGColor] = [TColor.cgColor, BColor.cgColor]
//        let gradientLayer: CAGradientLayer = CAGradientLayer()
        colors = gradientColors
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 1, y: 0)
        frame = bounds
    }
}

