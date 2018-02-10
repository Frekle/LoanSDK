//
//  Layout.swift
//  UTOO
//
//  Created by Frekle on 2017/6/15.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import Foundation
import SnapKit

struct Layout<View: UIView> {
    let view: View
    init(_ view: View) {
        self.view = view
    }
}

extension NSObjectProtocol where Self: UIView {
    var layout: Layout<Self> {
        return Layout(self)
    }
}

extension UIConfig where View: UIView {
    var layout: Layout<View> {
        return Layout(view)
    }
}

extension Layout {
    //    func make(file: String = #file, line: UInt = #line, @noescape closure: (make: ConstraintMaker) -> Void) -> Layout {
    //        view.snp_makeConstraints(file, line: line, closure: closure)
    //        return self
    //    }
    
    func adhereTo(_ superView: UIView) -> Constraint<View> {
        superView.addSubview(view)
        return Constraint(view)
    }
}
