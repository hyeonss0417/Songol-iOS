//
//  UserNameSelection.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 14..
//  Copyright © 2018년 최민섭. All rights reserved.
//
class UserNameSelection {
    func usernameSelection(snum: String) -> String{
        
        let snum = snum.prefix(4)
        
        if Int(snum)! >= 2018 {
            return "신입생입니다!"
        }else if Int(snum)! == 2017{
            return "성인입니다!"
        }else if Int(snum)! == 2016{
            return "짬 좀 찼습니다"
        }else if Int(snum)! == 2015{
            return "어떤 아재"
        }else if Int(snum)! == 2014 || Int(snum)! == 2013{
            return "잊혀져간다.."
        }else {
            return ". . . ."
        }
    }
}
