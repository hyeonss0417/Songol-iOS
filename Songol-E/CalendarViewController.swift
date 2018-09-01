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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
