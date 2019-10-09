//
//  LoginHelper.swift
//  Songol-E
//
//  Created by 최민섭 on 20/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//
import WebKit

enum ResultState {
    case success
    case failure
}

class LoginHelper: UIView, WKNavigationDelegate {
    private var id: String!
    private var pw: String!
    private let portalWebview = WKWebView()
    private let dialog = LoadingDialog()
    private var completion: (UserType, ResultState) -> Void = {_,_ in }
    
    func tryLogin(id: String, pw: String, parent: UIViewController, showDialog: Bool = true, completion: @escaping (UserType, ResultState) -> Void) {
        self.id = id
        self.pw = pw
        self.completion = completion
        
        parent.view.addSubview(self)
        
        showDialog ? dialog.displaySpinner(on: parent.view) : nil
        setupPortalWebkit()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let currentUrl = webView.url?.absoluteString else {return}
        print(currentUrl)
        switch currentUrl {
        case UrlPortalLogin:
            CommonUtils.sharedInstance.macroKauLogin(on: webView, id: id!, pw: pw!)
            break
        case UrlMyPortal:
            CommonUtils.sharedInstance.storeCookiesFromWKWebview() { res in
                self.loginSuccess()
            }
            break
        case UrlLMSLoginFail, UrlPortalLoginFail:
            loginFail()
            break
        default:
            break
        }
    }
    
    private func setupPortalWebkit() {
        for view in self.subviews {
            if view is WKWebView {
                view.removeFromSuperview()
            }
        }
        
        self.addSubview(portalWebview)
        portalWebview.navigationDelegate = self
        portalWebview.loadWithStringUrl(url: UrlPortalLogin, cookie: false)
    }
    
    private func loginFail() {
        self.completion(.normal, .failure)
        self.dialog.removeSpinner()
    }
    
    private func loginSuccess() {
        UserUtil.getType(id: id) { type in
            for subview in self.subviews {
                subview.removeFromSuperview()
            }
            self.completion(type, .success)
            self.dialog.removeSpinner()
        }
    }
}
