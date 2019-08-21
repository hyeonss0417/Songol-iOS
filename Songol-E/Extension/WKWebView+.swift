//
//  WKWebView+.swift
//  Songol-E
//
//  Created by 최민섭 on 18/07/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView{    
    func loadWithStringUrl(url: String, cookie: Bool = true, redirectUrl: String? = nil){
        var webrequest = URLRequest(url:URL(string: url)!)
        
        guard let storedCookies = HTTPCookieStorage.shared.cookies(for: URL(string: url)!), cookie else {
            return
        }
        
        print("storedCookies : \(storedCookies)")
        var cookies = HTTPCookie.requestHeaderFields(with: storedCookies)
        
        if let value = cookies["Cookie"] {
            webrequest.addValue(value, forHTTPHeaderField: "Cookie")
        }
        
        if let redirectUrl = redirectUrl, storedCookies.count == 0 {
            self.load(URLRequest(url: URL(string: redirectUrl)!))
        }
        else {
            self.load(URLRequest(url:URL(string: url)!))
        }
    }
}
