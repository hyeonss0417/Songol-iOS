//
//  ClubViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 26..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class WebInfoViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    var barTitle:String?
    var url:URL?
    var userinfo: UserInfo?
    
    public func setWebInfo(barTitle:String, url:String){
        self.barTitle = barTitle
        self.url = URL(string: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userinfo = AccountInfo().getUserInfo()
        
        self.title = barTitle
        
        webView.loadRequest(URLRequest(url: url!))
        
        webView.scalesPageToFit = true
        
        // Do any additional setup after loading the view.
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print("tagg url: ", request.url)
        
        if request.url?.absoluteString == urlKAU{
            self.webView.loadRequest(URLRequest(url: URL(string:urlMyPortal)!))
        }else if request.url?.absoluteString == urlMyPortal{
            self.webView.loadRequest(URLRequest(url: URL(string:urlExamTable)!))
        }
        return true
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let height = self.webView.scrollView.contentSize.height // 실제 페이지의 height
        
        self.webView.frame.size.height = 1 // height를 1로 설정하고 나서 다시 height를 바꿔줘야 제대로 동작한다.
        self.webView.frame.size.height = height
        
        print("tagg url:::: ", webView.request?.url)
        
        if webView.request?.url?.absoluteString == urlKAULogin
        {
            
            let loadUsernameJS = "document.getElementsByName('p_id')[0].value = \'\(userinfo?.username as! String)\';"
            
            let loadPasswordJS = "document.getElementsByName('p_pwd')[0].value = \'\(userinfo?.pw as! String)\';"
            
            let onClickEventJS =  "var cells = document.getElementsByTagName('img');" + "for(var i=0; i < cells.length; i++){ var status = cells[i].getAttribute('alt');if(status=='로그인버튼'){ cells[i].click(); break;} }"
            
            self.webView.stringByEvaluatingJavaScript(from: loadUsernameJS)
            self.webView.stringByEvaluatingJavaScript(from: loadPasswordJS)
            self.webView.stringByEvaluatingJavaScript(from: onClickEventJS)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
