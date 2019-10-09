//
//  UserNameSelection.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 14..
//  Copyright © 2018년 최민섭. All rights reserved.
//
struct AccountInfo{
    public func getUserInfo() -> UserInfo{
        let decoded  = UserDefaults.standard.object(forKey: "user") as! Data
        let userinfo = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserInfo
        return userinfo
    }
    
    public func storeUserInfo(userInfo : UserInfo){
        //store UserInfo
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: userInfo)
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: "user")
        CommonUtils.sharedInstance.setUser(user: userInfo)
    }
}
