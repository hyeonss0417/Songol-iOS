//
//  CommonUtils.swift
//  Songol-E
//
//  Created by 최민섭 on 18/07/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import WebKit

final class CommonUtils: NSObject {

    static let sharedInstance = CommonUtils()
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var isGuest = false
    var user: UserInfo?
    
    var cookieStore: WKHTTPCookieStore?
    
    func setUser(user: UserInfo){
        self.user = user
    }
    
    //Replace Root ViewController ex) Login, Logout...
    func replaceRootViewController(identifier: ViewControllerNameType){
        UIApplication.shared.keyWindow?.rootViewController =
            UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: identifier.rawValue)
    }
    
    //Push ViewController on NavigationViewController
    func pushOnNavigationController(navVC: UINavigationController?, identifier: ViewControllerNameType, url: String? = nil, title: String, redirectUrl: String? = nil){
        let target = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: identifier.rawValue)
        
        switch identifier {
        case .accessToWeb:
            if let vc = target as? AccessWebViewController {
                vc.stringURL = url!
                vc.title = title
                vc.redirectUrl = redirectUrl
            }
        case .developerIntroducing:
            if let vc = target as? DeveloperViewController {
                
            }
        case .login:
            break
        default:
            break
        }
        
        navVC?.pushViewController( target, animated: true)
    }

    //Kau Website Login with js
    func macroKauLogin(on wk: WKWebView, id: String, pw: String) {
        print("start macro")
        let loadUsernameJS = "document.getElementsByName('p_id')[0].value = \'\(id)\';"
        let loadPasswordJS = "document.getElementsByName('p_pwd')[0].value = \'\(pw)\';"
        let onClickEventJS =  "var cells = document.getElementsByTagName('img');" + "for(var i=0; i < cells.length; i++){ var status = cells[i].getAttribute('alt');if(status=='로그인버튼'){ cells[i].click(); break;} }"
        
        wk.evaluateJavaScript(loadUsernameJS + loadPasswordJS + onClickEventJS, completionHandler: nil)
    }
    
    func macroLMSLogin(on wk: WKWebView, id: String, pw: String) {
        print("start macro lms")
        let loadUsernameJS = "document.getElementsByName('username')[0].value = \'\(id)\';"
        let loadPasswordJS = "document.getElementsByName('password')[0].value = \'\(pw)\';"
        let submitFormJS = "document.getElementsByTagName('form')[0].submit();"
        
        wk.evaluateJavaScript(loadUsernameJS + loadPasswordJS + submitFormJS) { a,b in}
    }
    
    func storeCookiesFromWKWebview(completion: @escaping ([HTTPCookie]) -> Void) {
        var taskSuccess = false
        
        Timers.set(duration: 4, completion: {
            if !taskSuccess {
                self.storeCookiesFromWKWebview(completion: completion)
            } else {
                return
            }
        })
        
        WKWebsiteDataStore.default().httpCookieStore.getAllCookies { (cookies) in
            for cookie in cookies{
                HTTPCookieStorage.shared.setCookie(cookie)
                print("@@@ cookie ==> \(cookie.name) : \(cookie.value) :\(cookie.domain)")
            }
            
            taskSuccess = true
            completion(cookies)
        }
    }

    func removeAllCookiesFromWKWebview() {
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) {
            (records) -> Void in
            for record in records {
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
        
        //HTTPCookieStorage.shared.cookies?.removeAll()
        guard let cookies =  HTTPCookieStorage.shared.cookies else {return}
        for cookie in cookies {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
    }
    
    func clearCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        print("[WebCacheCleaner] All cookies deleted")
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("[WebCacheCleaner] Record \(record) deleted")
            }
        }
    }
}
