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
    private var lmsWebview = WKWebView()
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
        
        showDialog ? dialog.displaySpinner(on: parent.view) : nil
//         self.addSubview(lmsWebview)
//        lmsWebview.navigationDelegate = self
//        lmsWebview.loadWithStringUrl(url: UrlLmsLogin1)
        setupPortalWebkit()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let currentUrl = webView.url!.absoluteString
        print(currentUrl)
        switch currentUrl {
//        case UrlLmsLogin1:
//            CommonUtils().macroLMSLogin(on: webView, id: id!, pw: pw!)
        case UrlPortalLogin:
            CommonUtils().macroKauLogin(on: webView, id: id!, pw: pw!)
//        case UrlMyLms:
//            lmsLoginState = true
//            CommonUtils().storeCookiesFromWKWebview() { res in
//                self.setupPortalWebkit()
//            }
        case UrlMyPortal:
            portalLoginState = true
            lmsLoginState = true // lms 로그인 테스팅 과정 중이라 생략
            CommonUtils().storeCookiesFromWKWebview() { res in
                if res.count == 0 {
                    self.completion(.normal, .failure)
                } else {
                    self.loginSuccess()
                }
            }
        case UrlLMSLoginFail, UrlPortalLoginFail:
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
        portalWebview.loadWithStringUrl(url: UrlPortalLogin, cookie: false)
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
