//
//  ClubViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 26..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import WebKit

class WebInfoViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var wkWebView: WKWebView?
    
    var barTitle:String?
    var url:String?
    var userinfo: UserInfo?
    
    public func setWebInfo(barTitle:String, url:String){
        self.barTitle = barTitle
        self.url = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userinfo = AccountInfo().getUserInfo()
        
        self.title = barTitle
        
        wkWebView?.loadWithStringUrl(url: url!)
        
        wkWebView?.sizeToFit()
        
        // Do any additional setup after loading the view.
    }
}
