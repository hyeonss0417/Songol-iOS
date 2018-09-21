//
//  IconSelection.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 14..
//  Copyright © 2018년 최민섭. All rights reserved.
//

class IconSelection{
    
    func iconSelection(snum:String) -> UIImage{
        
        let snum = snum.prefix(4)
    
        if Int(snum)! >= 2018 {
            return #imageLiteral(resourceName: "chick1")
        }else if Int(snum)! == 2017{
            return #imageLiteral(resourceName: "chick2")
        }else if Int(snum)! == 2016{
            return #imageLiteral(resourceName: "chick3")
        }else if Int(snum)! == 2015{
            return #imageLiteral(resourceName: "chick4")
        }else if Int(snum)! == 2014 || Int(snum)! == 2013{
            return #imageLiteral(resourceName: "chick5")
        }else {
            return #imageLiteral(resourceName: "chick6")
        }
    }
}
