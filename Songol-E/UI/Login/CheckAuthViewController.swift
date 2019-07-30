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
            //게스트 계정 로그인 시 3초 대기
            Timers().set(duration: 3){
                CommonUtils().replaceRootViewController(identifier: "SWRevealViewController")
            }
        }
        
        wkWebView.loadWithStringUrl(url: UrlPortalLogin)
        wkWebView.navigationDelegate = self
    }

    func kauLoginOnSuccess(){
        //store cookies
        CommonUtils().storeCookiesFromWKWebview()
        CommonUtils().replaceRootViewController(identifier: "SWRevealViewController")
    }
    
    func kauLoginOnFail(){
        CommonUtils().replaceRootViewController(identifier: "loginViewController")
    }
}

extension CheckAuthViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let currentUrl = webView.url!.absoluteString
        print("login proccess url : \(currentUrl)")
        switch currentUrl {
            case UrlPortalLoginProcess, UrlPortalLogin :
                CommonUtils().macroKauLogin(on: wkWebView, id: user!.username!, pw: user!.pw!)
            case UrlLmsLoginSuccess, UrlMyPortal:
                //LoginSuccess
                kauLoginOnSuccess()
            case UrlLMSLoginFail:
                kauLoginOnFail()
            case "https://www.kau.ac.kr/page/act_login.jsp":
                //방화벽 차단 당했을때 처리??
                print("blocked")
            default:
                print("where..? : \(currentUrl)")
        }
    }
}
