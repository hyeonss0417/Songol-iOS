//
//  DisignableUIView.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 17..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView{
    
    @IBInspectable var cornerRadius:CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
}

