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
    private var lmsLoginState = false
    private var portalLoginState = false
    private var id: String!
    private var pw: String!
    private let lmsWebview = WKWebView()
    private let portalWebview = WKWebView()
    private var portalCookies: [HTTPCookie] = []
    private var lmsCookies: [HTTPCookie] = []
    private let dialog = LoadingDialog()
    private var completion: (UserType, ResultState) -> Void = {_,_ in }
    
    func tryLogin(id: String, pw: String, parent: UIViewController, showDialog: Bool = true, completion: @escaping (UserType, ResultState) -> Void) {
        self.id = id
        self.pw = pw
        self.completion = completion
        
        parent.view.addSubview(self)
        self.addSubview(lmsWebview)
        
        lmsWebview.navigationDelegate = self
        showDialog ? dialog.displaySpinner(on: parent.view) : nil
        lmsWebview.loadWithStringUrl(url: UrlLmsLogin1)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let currentUrl = webView.url!.absoluteString
        switch currentUrl {
        case UrlLmsLogin1, UrlPortalLogin:
            CommonUtils().macroKauLogin(on: webView, id: id!, pw: pw!)
        case UrlMyLms:
            lmsLoginState = true
            CommonUtils().storeCookiesFromWKWebview() {
                self.setupPortalWebkit()
            }
        case UrlMyPortal:
            portalLoginState = true
            CommonUtils().storeCookiesFromWKWebview() {
                self.loginSuccess()
            }
        case UrlLMSLoginFail:
            self.completion(.normal, .failure)
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
        portalWebview.loadWithStringUrl(url: UrlPortalLogin)
    }
    
    private func loginSuccess() {
        if !lmsLoginState, !portalLoginState {
            return
        }
        
        UserUtil.getType(id: id) { type in
            for subview in self.subviews {
                subview.removeFromSuperview()
            }
            self.completion(type, .success)
            self.dialog.removeSpinner()
        }
    }
}
