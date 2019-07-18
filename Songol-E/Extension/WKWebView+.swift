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
    
    
    func loadWithStringUrl(url: String){
        
        self.load(URLRequest(url:URL(string: UrlLmsLoginSuccess)!))
    }
    
}
