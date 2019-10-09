//
//  DeliveryTableViewCell.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 2..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class DeliveryTableViewCell: UITableViewCell {
    @IBOutlet weak var imageLogo: UIImageView! {
        didSet {
            imageLogo.image = UIImage()
            imageLogo.layer.borderWidth = 1
            imageLogo.contentMode = .scaleToFill
            imageLogo.layer.masksToBounds = false
            imageLogo.layer.borderColor = UIColor.white.cgColor
            imageLogo.layer.cornerRadius = imageLogo.frame.height/2
            imageLogo.clipsToBounds = true
        }
    }
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
}
