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
    
    //MARK:- Properties
    private var wkWebView: WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let wkWebview = WKWebView(frame: .zero, configuration: configuration)
        wkWebview.isHidden = true
        return wkWebview
    }()
    private var webView: UIWebView = {
        let webView = UIWebView(frame: .zero)
        webView.isHidden = true
        return webView
    }()
    
    var stringURL: String = String() {
        didSet {
            if stringURL.elementsEqual(URLCurrentScore) {
                wkWebView.configuration.preferences.javaScriptEnabled = false
            }
        }
    }
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func loadView() {
        super.loadView()
        
        if #available(iOS 11, *) {
            setupWKWebView()
        } else {
            setupWebView()
        }
    }
    
    private func setupWKWebView() {
        wkWebView.navigationDelegate = self
        self.view.addSubview(wkWebView)
        wkWebView.addAutoLayout(parent: self.view)
        wkWebView.loadWithStringURL(url: stringURL)
    }
    
    private func setupWebView() {
        webView.delegate = self
        self.view.addSubview(webView)
        webView.addAutoLayout(parent: self.view)
        webView.scalesPageToFit = true
        webView.loadWithStringURL(url: stringURL)
    }
}

extension AccessWebViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        guard let currentUrl = webView.request?.url?.absoluteString else { return }
        print(currentUrl)
        switch currentUrl {
        case UrlLmsLogin1:
            JSRequest.macroLMSLogin(on: webView, id: user.username, pw: user.pw)
            break
        case stringURL:
            webView.isHidden = false
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
}

extension AccessWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let currentUrl = webView.url?.absoluteString else { return }
        print(currentUrl)
        switch currentUrl {
            case UrlLmsLogin1:
                JSRequest.macroLMSLogin(on: wkWebView, id: user.username, pw: user.pw)
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
        if navigationAction.navigationType == .formSubmitted && (stringURL == UrlScore)
        {
            if let url = navigationAction.request.url
            {
                decisionHandler(.cancel)
                webView.loadWithStringURL(url: url.absoluteString)
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
