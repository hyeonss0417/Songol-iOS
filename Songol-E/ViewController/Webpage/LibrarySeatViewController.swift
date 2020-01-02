//
//  LibrarySeatViewController.swift
//  Songol
//
//  Created by 최민섭 on 2018. 8. 29..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class LibrarySeatViewController: ButtonBarPagerTabStripViewController , UIWebViewDelegate{

    let screenWidth = UIScreen.main.bounds.width
    
    let blueInspireColor = UIColor(red: 34/255.0, green: 45/255.0, blue: 103/255.0, alpha: 1.0)
    let oldCellColor = UIColor(displayP3Red: 0.07, green: 0.27, blue: 0.53, alpha: 0.4)
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "열람실 좌석현황"
        
        initTabBar()
        
        do{
            var helpURL = URL(string: "http://ebook.kau.ac.kr:81/domian5.asp")
            
            var data = try Data(contentsOf: helpURL!)
            webView?.load(data, mimeType: "text/html", textEncodingName: "euc-kr", baseURL: helpURL!)
            // 인코딩만 넣어주면 됩니다.
            
        } catch {}
        
        webView.scalesPageToFit = true
    }
    
    func initTabBar(){
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = blueInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 15)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        settings.style.buttonBarItemLeftRightMargin = 0
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = self?.oldCellColor
            newCell?.label.textColor = self?.blueInspireColor
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "libraryChild") as! LibrarySeatChildViewController
        child_1.setUrlAndTitle(url: "http://ebook.kau.ac.kr:81/roomview5.asp?room_no=1", category: "1열A")
        
        let child_2 = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "libraryChild") as! LibrarySeatChildViewController
        child_2.setUrlAndTitle(url: "http://ebook.kau.ac.kr:81/roomview5.asp?room_no=2",category: "1열B")
        
        let child_3 = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "libraryChild") as! LibrarySeatChildViewController
        child_3.setUrlAndTitle(url: "http://ebook.kau.ac.kr:81/roomview5.asp?room_no=3",category: "2열")
        
        let child_4 = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "libraryChild") as! LibrarySeatChildViewController
        child_4.setUrlAndTitle(url:"http://ebook.kau.ac.kr:81/roomview5.asp?room_no=4",category: "3열")
        
        let child_5 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "libraryChild") as! LibrarySeatChildViewController
        child_5.setUrlAndTitle(url: "http://ebook.kau.ac.kr:81/roomview5.asp?room_no=5", category: "5열")
        
        return [child_1, child_2, child_3, child_4, child_5]
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let height = self.webView.scrollView.contentSize.height // 실제 페이지의 height
        
        self.webView.frame.size.height = 1 // height를 1로 설정하고 나서 다시 height를 바꿔줘야 제대로 동작한다.
        self.webView.frame.size.height = height
    }
}
