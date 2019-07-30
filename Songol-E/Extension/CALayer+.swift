//
//  CALayer+.swift
//  Songol-E
//
//  Created by 최민섭 on 30/07/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
}
