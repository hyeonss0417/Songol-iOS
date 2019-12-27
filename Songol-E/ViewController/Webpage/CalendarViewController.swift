
//
//  CalendarViewController.swift
//  Songol
//
//  Created by 최민섭 on 2018. 8. 29..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "학사일정"
        
        let url = URL(string: "http://m.kau.ac.kr/page/mobile/term/term_01.jsp")
        webView.loadRequest(URLRequest(url: url!))
    }
}
