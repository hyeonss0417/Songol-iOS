//
//  DeliveryTableViewCell.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 2..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class DeliveryTableViewCell: UITableViewCell {

    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}