//
//  LMSViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 17..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import WebKit
import UIKit

class AccessWebViewController: BaseUIViewController{
    @IBOutlet weak var wkWebView: WKWebView!
    var stringURL: String!
    var redirectUrl: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wkWebView.navigationDelegate = self
        wkWebView.isHidden = true
        wkWebView.loadWithStringUrl(url: stringURL)
        loadingDialog.displaySpinner(on: self.view)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allowWebKitGesture(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        allowWebKitGesture(false)
    }
}

extension AccessWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let currentUrl = webView.url!.absoluteString
        print(currentUrl)
        switch currentUrl {
            case UrlLmsLogin1:
                CommonUtils().macroLMSLogin(on: wkWebView, id: user!.username!, pw: user!.pw!)
                break
            case stringURL:
                wkWebView.isHidden = false
                loadingDialog.removeSpinner()
                allowWebKitGesture(false)
                break
            case "https://www.kau.ac.kr/page/act_login.jsp":
                //방화벽 차단 당했을때 처리
                print("blocked")
                break
            default:
                allowWebKitGesture(true)
                break
            }
    }
    
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void)
    {
        if navigationAction.navigationType == .formSubmitted && (stringURL == UrlScore || stringURL == UrlProfessors)
        {
            if let url = navigationAction.request.url
            {
                decisionHandler(.cancel)
                webView.loadWithStringUrl(url: url.absoluteString)
            }
            return
        }
        
        decisionHandler(.allow)
    }

    func allowWebKitGesture(_ allow: Bool){
         wkWebView.allowsBackForwardNavigationGestures = allow
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = !allow
    }
}
