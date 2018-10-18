//
//  DeleteCookieAndCaches.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 18..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import Foundation

class CookieAndCache{
    
    func removeAll(){
        let cookie = HTTPCookie.self
        let cookieJar = HTTPCookieStorage.shared
        
        for cookie in cookieJar.cookies! {
            cookieJar.deleteCookie(cookie)
        }
        
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
    }
    
}
