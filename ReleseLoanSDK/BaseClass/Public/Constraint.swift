//
//  Constraint.swift
//  UTOO
//
//  Created by Frekle on 2017/6/15.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import Foundation
import SnapKit

struct Constraint<View: UIView> {
    let view: View
    init(_ view: View) {
        self.view = view
    }
}

extension Constraint {
    func make(closure: (_ make: ConstraintMaker) -> Void) -> Constraint {
        view.snp.makeConstraints(closure)
        return self
    }
}
