//
//  CheckAuthViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 18/07/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import WebKit

class CheckAuthViewController: BaseUIViewController {
    
    @IBOutlet weak var wkWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user?.username == "guest" {
            
            Timers().set(duration: 3){
                UIApplication.shared.keyWindow?.rootViewController =
                    CommonUtils().mainStoryboard
                        .instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            }
        }
        
        wkWebView.loadWithStringUrl(url: UrlMyLms)
        
        wkWebView.navigationDelegate = self
        
    }
    
    public func kauLoginOnSuccess(){
        
        let cookieStore = wkWebView.configuration.websiteDataStore.httpCookieStore
        cookieStore.getAllCookies { (cookies) in
            print("cookies : \(cookies)")
        }
        
        UIApplication.shared.keyWindow?.rootViewController =
            CommonUtils().mainStoryboard
                .instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
    }
    public func kauLoginOnFail(){
        
        UIApplication.shared.keyWindow?.rootViewController =
            CommonUtils().mainStoryboard
                .instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
    }
}

extension CheckAuthViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        let currentUrl = webView.url!.absoluteString
        switch currentUrl {
            case UrlLmsLogin1, UrlLmsLogin2 :
                CommonUtils().macroKauLogin(on: wkWebView, id: user!.username!, pw: user!.pw!)
                break
            case UrlLmsLoginSuccess:
                //LoginSuccess
                kauLoginOnSuccess()
                break
            case UrlLMSLoginFail:
                kauLoginOnFail()
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
