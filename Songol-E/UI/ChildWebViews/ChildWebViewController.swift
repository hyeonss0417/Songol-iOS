
//
//  File.swift
//  Songol-E
//
//  Created by 최민섭 on 17/11/2018.
//  Copyright © 2018 최민섭. All rights reserved.
//

import UIKit
import WebKit
class ChildWebViewController : UIViewController {
    @IBOutlet weak var wkWebView: WKWebView!
    private var stringURL: String?
    private var stringTitle : String?
    
    func setURL(stringURL: String){
        
        self.stringURL = stringURL
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wkWebView.loadWithStringUrl(url: stringURL!)
        wkWebView.sizeToFit()
    }
    
}
