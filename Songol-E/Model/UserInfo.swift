//
//  UserInfo.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 11..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import Foundation

class UserInfo : NSObject, NSCoding{
    var major: String
    var pw: String
    var snumber: String
    var username: String
    var uid: String
    
    init(uid: String = "", major: String = "", pw: String, snumber: String = "", username: String) {
        self.uid = uid
        self.major = major
        self.pw = pw
        self.snumber = snumber
        self.username = username
    }
    
    // MARK: - NSCoding
    required init(coder aDecoder: NSCoder) {
        do {
            try uid = aDecoder.decodeObject(forKey: "uid") as! String
            try major = aDecoder.decodeObject(forKey: "major") as! String
            try pw = aDecoder.decodeObject(forKey: "pw") as! String
            try snumber = aDecoder.decodeObject(forKey: "snumber") as! String
            try username = aDecoder.decodeObject(forKey: "username") as! String
        } catch {
            print("wrong type access")
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(major, forKey: "major")
        aCoder.encode(pw, forKey: "pw")
        aCoder.encode(snumber, forKey: "snumber")
        aCoder.encode(username, forKey: "username")
    }
    
    
}
