
//
//  File.swift
//  Songol-E
//
//  Created by 최민섭 on 17/11/2018.
//  Copyright © 2018 최민섭. All rights reserved.
//

import UIKit

class ChildWebViewController : UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var mWebView: UIWebView!
    
    private var stringURL: String?
    private var stringTitle : String?
    
    func setURL(stringURL: String){
        
        self.stringURL = stringURL
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initWebView()
        
    }
    
    func initWebView(){
        print("=== hello")
        mWebView.loadRequest(URLRequest(url: URL(string: stringURL!)!))
        mWebView.scalesPageToFit = true
    
    }
    
}
