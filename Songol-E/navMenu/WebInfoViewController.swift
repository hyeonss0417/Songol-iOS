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
    
    public func setWebInfo(barTitle:String, url:String){
        self.barTitle = barTitle
        self.url = URL(string: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = barTitle
        
        webView.loadRequest(URLRequest(url: url!))
        
        webView.scalesPageToFit = true
        
        // Do any additional setup after loading the view.
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let height = self.webView.scrollView.contentSize.height // 실제 페이지의 height
        
        self.webView.frame.size.height = 1 // height를 1로 설정하고 나서 다시 height를 바꿔줘야 제대로 동작한다.
        self.webView.frame.size.height = height
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
