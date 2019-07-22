//
//  CheckAuthViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 18/07/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import WebKit

class CheckAuthViewController: UIViewController {
    
    @IBOutlet weak var wkWebView: WKWebView!
    
    let user = CommonUtils.sharedInstance.user

    override func viewDidLoad() {
        super.viewDidLoad()
        
        wkWebView.loadWithStringUrl(url: UrlMyLms)
        
        wkWebView.navigationDelegate = self
        
    }
    
    public func kauLoginOnSuccess(){
         UIApplication.shared.keyWindow?.rootViewController =
            CommonUtils.mainStoryboard
                .instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
    }
    public func kauLoginOnFail(){
        
        UIApplication.shared.keyWindow?.rootViewController =
            CommonUtils.mainStoryboard
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
                break
            default:
                print("where..? : \(currentUrl)")
                break
        }
    }
}
