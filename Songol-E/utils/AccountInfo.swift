//
//  UserNameSelection.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 14..
//  Copyright © 2018년 최민섭. All rights reserved.
//
struct AccountInfo{
    func usernameSelection(snum: String) -> String{
        
        let snum = snum.prefix(4)
        if  Int(snum)! == 7777 {
            return "친절한 송골이"
        }else if Int(snum)! == 0000{
            return "항공대 처음이에유"
        }else if Int(snum)! >= 2018 {
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
    
    func userIconSelection(snum: String) -> UIImage{
        
        let snum = snum.prefix(4)
    
        if  Int(snum)! == 7777 {
            return #imageLiteral(resourceName: "kindsongol")
        }else if Int(snum)! == 0000{
            return #imageLiteral(resourceName: "chick0")
        }
        else if Int(snum)! >= 2018 {
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
    
    func navUserIconSelection(snum: String) -> UIImage{
        
        let snum = snum.prefix(4)
        
        if  Int(snum)! == 7777 {
            return #imageLiteral(resourceName: "kindsongol_")
        }else if Int(snum)! == 0000{
            return #imageLiteral(resourceName: "chick0_")
        }
        else if Int(snum)! >= 2018 {
            return #imageLiteral(resourceName: "chick1_")
        }else if Int(snum)! == 2017{
            return #imageLiteral(resourceName: "chick2_")
        }else if Int(snum)! == 2016{
            return #imageLiteral(resourceName: "chick3_")
        }else if Int(snum)! == 2015{
            return #imageLiteral(resourceName: "chick4_")
        }else if Int(snum)! == 2014 || Int(snum)! == 2013{
            return #imageLiteral(resourceName: "chick5_")
        }else {
            return #imageLiteral(resourceName: "chick6_")
        }
        
    }
    
    func getSnumberFromImageSrc(img:UIImage) -> String{
        
        print("tagg","am i wrong ??")
        
        if img == #imageLiteral(resourceName: "chick0_") || img == #imageLiteral(resourceName: "chick0")  {
            return guestSnum
        }else if img == #imageLiteral(resourceName: "chick1_") || img == #imageLiteral(resourceName: "chick1") {
            return freshmanSnum
        }else if img  == #imageLiteral(resourceName: "chick2_") || img == #imageLiteral(resourceName: "chick2") {
            return sophomoreSnum
        }else if img == #imageLiteral(resourceName: "chick3_") || img == #imageLiteral(resourceName: "chick3") {
            return juniorSnum
        }else if img == #imageLiteral(resourceName: "chick4_") || img == #imageLiteral(resourceName: "chick4") {
            return seniorSnum
        }else if img == #imageLiteral(resourceName: "chick5") || img == #imageLiteral(resourceName: "chick5_"){
            return oldGuysSnum
        }else if img == #imageLiteral(resourceName: "chick6_") || img == #imageLiteral(resourceName: "chick6") {
            return oldMenSnum
        }else{
            return kindSongolSnum
        }
        
    }
    
    public func getUserInfo() -> UserInfo{
        let decoded  = UserDefaults.standard.object(forKey: "key1") as! Data
        let userinfo = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserInfo
            
        return userinfo
    }
    
    public func storeUserInfo(userInfo : UserInfo){
        //store UserInfo
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: userInfo)
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: "key1")
    }
}
