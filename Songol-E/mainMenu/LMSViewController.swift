//
//  LMSViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 17..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class LMSViewController: UIViewController, UIWebViewDelegate{
    
    @IBOutlet weak var mWebView: UIWebView!
    
    let stringURL = "http://lms.kau.ac.kr/my/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My LMS"
        
        initWebView()
    }
    
    func initWebView(){
        
        let url = URL(string: stringURL)
        mWebView.loadRequest(URLRequest(url: url!))
        mWebView.scalesPageToFit = true
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("tagg: lms:  ", request.url?.absoluteString )
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
