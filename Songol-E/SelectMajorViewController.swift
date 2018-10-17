//
//  SelectMajorViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 7..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import SwiftSoup

class SelectMajorViewController: UIViewController, UIWebViewDelegate {
    
    var preSelectedBtn: UIButton?
    var username, password:String?
    var userInfo:UserInfo?
    var major : String?
    var uid:String?
    
    @IBOutlet weak var mWebView: UIWebView!
    
    func storeUserInfo(){
        //store UserInfo
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: userInfo)
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: "key1")
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
         getJSessionIdCookie()
    }
    
    @IBAction func changeMajor(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
        preSelectedBtn?.backgroundColor = UIColor.clear
        preSelectedBtn = button
        if button.tag != 10 {
            major = button.currentTitle
            button.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            print(button.currentTitle!)
        }
        
        if  button.tag == 10 && major != nil {
            //start main viewController with User Data
            userInfo = UserInfo(uid:uid!, major: major!, pw: password!, snumber: "1111", username: username!)
            
            //have to make firebase DB 
            
            performSegue(withIdentifier: "SWRevealWithSignin", sender: nil)
        }
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SWRevealWithSignin"{
            storeUserInfo()
        }
    }
    
    public func setUserData(uid:String, username: String, password:String){
        self.uid = uid
        self.username = username
        self.password = password
    }
    
    override func viewDidLoad() {
//
//        mWebView.loadRequest(URLRequest(url: URL(string: "https://portal.kau.ac.kr/sugang/SugangOrderList.jsp")!))
      //  getJSessionIdCookie()
        
    }
    
    func getJSessionIdCookie(){

        let cookieStorage = HTTPCookieStorage.shared
        let cookies = cookieStorage.cookies as! [HTTPCookie]

        var jsessionID: HTTPCookie?

        print("tagg Cookies.count: \(cookies.count)")
        for cookie in cookies {
            print("tagg name: \(cookie.name) value: \(cookie.value) domain:\(cookie.domain)" )
            if cookie.name == "JSESSIONID"{
                jsessionID = cookie
                break
            }
        }
        do{
//            let snum = try GetSNumber("https://portal.kau.ac.kr/sugang/SugangOrderList.jsp")
            //getSNumber()
        }catch{}

    }
    
    func euckrEncoding(_ query: String) -> String { //EUC-KR 인코딩
        
        let rawEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.EUC_KR.rawValue))
        let encoding = String.Encoding(rawValue: rawEncoding)
        
        let eucKRStringData = query.data(using: encoding) ?? Data()
        let outputQuery = eucKRStringData.map {byte->String in
            if byte >= UInt8(ascii: "A") && byte <= UInt8(ascii: "Z")
                || byte >= UInt8(ascii: "a") && byte <= UInt8(ascii: "z")
                || byte >= UInt8(ascii: "0") && byte <= UInt8(ascii: "9")
                || byte == UInt8(ascii: "_") || byte == UInt8(ascii: ".") || byte == UInt8(ascii: "-")
            {
                return String(Character(UnicodeScalar(UInt32(byte))!))
            } else if byte == UInt8(ascii: " ") {
                return "+"
            } else {
                return String(format: "%%%02X", byte)
            }
            }.joined()
        
        return outputQuery
    }
    
//    func getSNumber(){
//        do{
//            let htmlString = "https://portal.kau.ac.kr/sugang/SugangOrderList.jsp"
//
//            let html = try String(contentsOf: URL(string: htmlString)!)
//            print("tagg dd")
//            let doc = try SwiftSoup.parse(euckrEncoding(html))
//            let id =  try doc.select("td")
//            print("tagg", try id.size())
//
//            //var snumber:String = try id.get(0).text()
//            //        let startIdx = snumber.index(of: ":")
//            //        snumber[NSRange(location: startIdx, length: 12)]
//
//            //print("tagg", snumber)
//        }catch{
//            print("tagg",error)
//        }
//
//    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
