//
//  LMSViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 17..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import WebKit
import UIKit

class LMSViewController: BaseUIViewController{
    
    @IBOutlet weak var wkWebView: WKWebView!
    var stringURL = "http://lms.kau.ac.kr/my/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wkWebView.navigationDelegate = self
        wkWebView.isHidden = true
        wkWebView.loadWithStringUrl(url: stringURL)
    }
}

extension LMSViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let currentUrl = webView.url!.absoluteString
        switch currentUrl {
            
        case UrlLmsLogin1, UrlLmsLogin2:
            CommonUtils().macroKauLogin(on: wkWebView, id: user!.username!, pw: user!.pw!)
            break
        case stringURL:
            wkWebView.isHidden = false
            break
        case "https://www.kau.ac.kr/page/act_login.jsp":
            //방화벽 차단 당했을때 처리??
            print("blocked")
            break
        default:
            print("where..? : \(currentUrl)")
            break
        }
    }
}
