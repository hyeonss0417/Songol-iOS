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
    func loadWithStringURL(url: String, cookie: Bool = true){
        var webrequest = URLRequest(url:URL(string: url)!)
        
        if url == UrlMyLms {
            self.load(webrequest)
            return
        }
        
        if let storedCookies = HTTPCookieStorage.shared.cookies(for: URL(string: url)!) {
            print("storedCookies : \(storedCookies)")
            var cookies = HTTPCookie.requestHeaderFields(with: storedCookies)
            
            if let value = cookies["Cookie"] {
                webrequest.addValue(value, forHTTPHeaderField: "Cookie")
                
            }
        }
    
        self.load(webrequest)
    }
    
    func setHidden(_ hidden: Bool) {
        UIView.transition(with: self,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.isHidden = hidden },
                          completion: nil)
    }
}

extension UIWebView {
    func loadWithStringURL(url: String) {
        guard let url = URL(string: url) else {return}
        self.loadRequest(URLRequest(url: url))
    }
}
