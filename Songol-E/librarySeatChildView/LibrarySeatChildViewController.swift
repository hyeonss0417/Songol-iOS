//
//  LibrarySeatChildViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 2..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class LibrarySeatChildViewController: UIViewController, IndicatorInfoProvider, UIWebViewDelegate {

    var url : String?
    var category: String?
    
    @IBOutlet weak var webView: UIWebView!
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: category!)
    }
    
    func setUrlAndTitle(url:String, category:String){
        self.url = url
        self.category = category
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let width = self.webView.scrollView.contentSize.width // 실제 페이지의 height
        
        self.webView.frame.size.width = 1 // height를 1로 설정하고 나서 다시 height를 바꿔줘야 제대로 동작한다.
        self.webView.frame.size.width = width
    
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            
        
            var helpURL = URL(string: url!)
            
            var data = try Data(contentsOf: helpURL!)
            webView?.load(data, mimeType: "text/html", textEncodingName: "euc-kr", baseURL: helpURL!)
            // 인코딩만 넣어주면 됩니다.
        
        } catch {}
        
        

        
        //webView.loadRequest(URLRequest(url: URL(string: url!)!))
        
        webView.scalesPageToFit = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
