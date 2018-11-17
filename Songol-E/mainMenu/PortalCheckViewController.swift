//
//  File.swift
//  Songol-E
//
//  Created by 최민섭 on 14/11/2018.
//  Copyright © 2018 최민섭. All rights reserved.
//

import UIKit

class PortalCheckViewController : UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var mWebView: UIWebView!
    
    @IBOutlet weak var mFrameView: UIView!
    
    
    private let stringURL = "http://www.kau.ac.kr/page/act_Portal_Check.jsp"
    
    private var stringTitle: String?
    
    private var stringURL2:String?
    
    private var check = true
    
    var currentViewController : UIViewController?
    
    func setChildInfo(stringURL2: String, stringTitle: String){
        
        self.stringURL2 = stringURL2
        self.stringTitle = stringTitle
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = stringTitle
        
        initWebView()
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //print("===", mWebView.request?.url?.absoluteString)
        if  mWebView.request?.url?.absoluteString == "https://portal.kau.ac.kr/portal/MyPortal_No.jsp" && check {
            
            check = false
            // frame 만들어서 그 안에 WebView를 가진 ViewController를 부르면 된다 !!
            performSegue(withIdentifier: "childWebView", sender: nil)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? ChildWebViewController {
            destinationVC.setURL(stringURL: stringURL2!)
        }
        
    }
    
    private func initWebView(){
        
        mWebView.loadRequest(URLRequest(url: URL(string: stringURL)!))
        mWebView.scalesPageToFit = true
        
    }
    
}
