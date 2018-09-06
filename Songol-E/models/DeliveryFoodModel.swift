//
//  DeliveryFoodModel.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 2..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class DeliveryFoodModel {
    var foodName:String = ""
    var avg_speedScore:String = ""
    var avg_tasteScore: String = ""
    var imgLogo_url: String = ""
    var imgMenu_url: String = ""
    var number: String = ""
    var s_time: String = ""
    
    init(foodName:String, avg_speedScore:String, avg_tasteScore:String, imgLogo_url:String, imgMenu_url:String, number:String, s_time:String) {
        self.foodName = foodName
        self.avg_speedScore = avg_speedScore
        self.avg_tasteScore = avg_tasteScore
        self.imgLogo_url = imgLogo_url
        self.imgMenu_url = imgMenu_url
        self.number = number
        self.s_time = s_time
    }
}
