//
//  UserInfo.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 11..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import Foundation

class UserInfo : NSObject, NSCoding{

    var major:String?
    var pw:String?
    var snumber:String?
    var username:String?
    
    init(major:String, pw:String?, snumber:String?, username:String?) {
        self.major = major
        self.pw = pw
        self.snumber = snumber
        self.username = username
    }
    
    // MARK: - NSCoding
    required init(coder aDecoder: NSCoder) {

        major = aDecoder.decodeObject(forKey: "major") as! String
        pw = aDecoder.decodeObject(forKey: "pw") as! String
        snumber = aDecoder.decodeObject(forKey: "snumber") as! String
        username = aDecoder.decodeObject(forKey: "username") as! String
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(major, forKey: "major")
        aCoder.encode(pw, forKey: "pw")
        aCoder.encode(snumber, forKey: "snumber")
        aCoder.encode(username, forKey: "username")
    }
    
    
}
