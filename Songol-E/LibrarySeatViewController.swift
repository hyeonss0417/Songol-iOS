//
//  LibrarySeatViewController.swift
//  Songol
//
//  Created by 최민섭 on 2018. 8. 29..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class LibrarySeatViewController: UIViewController , UIWebViewDelegate{

    let screenWidth = UIScreen.main.bounds.width
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "열람실 좌석현황"
        
        let url = URL(string: "http://ebook.kau.ac.kr:81/domian5.asp")
        webView.loadRequest(URLRequest(url: url!))
        
        webView.scalesPageToFit = true
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
