//
//  LMSViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 17..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import WebKit
import UIKit

class LMSViewController: UIViewController{
    
    @IBOutlet weak var wkWebView: WKWebView!
    var stringURL = "http://lms.kau.ac.kr/my/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My LMS"
        
        wkWebView.loadWithStringUrl(url: stringURL)
    }
}
