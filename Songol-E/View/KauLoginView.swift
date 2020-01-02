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

class KauLoginView: UIView {
    private var id: String!
    private var pw: String!
    private let portalWKWebview = WKWebView()
    private let portalWebview = UIWebView()
    
    private let dialog = LoadingDialog()
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = label.font.withSize(15)
        label.text = "KAU 사이트에 접속 중입니다..."
        label.sizeToFit()
        return label
    }()
    private var completion: (UserType, ResultState) -> Void = {_,_ in }
    
    func tryLogin(id: String, pw: String, parent: UIViewController, showDialog: Bool = true, completion: @escaping (UserType, ResultState) -> Void) {
        self.id = id
        self.pw = pw
        self.completion = completion
        
        parent.view.addSubview(self)
        
        showDialog ? self.dialog.displaySpinner(on: parent.view) : nil
        showDialog ? self.addLoadingLabel() : nil
        
        if #available(iOS 11, *) {
            setupPortalWkWebview()
        } else {
            setupPortalWebview()
        }
    }
    
    private func addLoadingLabel() {
        dialog.addSubview(view: loadingLabel)
    }
    
    private func changeLabelText(text: String) {
        UIView.transition(with: self.loadingLabel,
             duration: 0.25,
              options: .transitionCrossDissolve,
           animations: { [unowned self] in
               self.loadingLabel.text = text
        }, completion: nil)
    }
    
    public func removeSpinner() {
        DispatchQueue.main.async {
            self.dialog.removeSpinner()
        }
    }
    
    private func setupPortalWkWebview() {
        self.addSubview(portalWKWebview)
        portalWKWebview.navigationDelegate = self
        portalWKWebview.loadWithStringURL(url: UrlPortalLogin, cookie: false)
    }
    
    private func setupPortalWebview() {
        self.addSubview(portalWebview)
        portalWebview.delegate = self
        portalWebview.loadWithStringURL(url: UrlPortalLogin)
    }
    
    private func loginFail() {
        self.completion(.normal, .failure)
        self.dialog.removeSpinner()
    }
    
    private func loginSuccess() {
        UserUtil.getType(id: id) { type in
            self.changeLabelText(text: "사용자 정보를 안전하게 저장하고 있습니다..")
            self.completion(type, .success)
        }
    }
}

extension KauLoginView: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        guard let currentUrl = webView.request?.url?.absoluteString else {return}
        switch currentUrl {
        case UrlPortalLogin:
            JSRequest.macroKauLogin(on: webView, id: id!, pw: pw!)
            break
        case UrlMyPortal:
            self.loginSuccess()
            break
        case UrlLMSLoginFail, UrlPortalLoginFail:
            loginFail()
            break
        default:
            break
        }
    }
}

extension KauLoginView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let currentUrl = webView.url?.absoluteString else {return}
        print(currentUrl)
        switch currentUrl {
        case UrlPortalLogin:
           JSRequest.macroKauLogin(on: webView, id: id!, pw: pw!)
            break
        case UrlMyPortal:
            CookieManager.storeCookiesFromWKWebview() { res in
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
}
