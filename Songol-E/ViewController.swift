//
//  ViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 8. 30..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIWebViewDelegate {
    
    private var isLogout = false
    private var stateLogin = false
    
    let blueInspireColor = UIColor(red: 34/255.0, green: 45/255.0, blue: 103/255.0, alpha: 1.0)
    
    @IBOutlet weak var navMenuButton: UIBarButtonItem!
    
    var positionValue : String?
    var currentViewController : ViewController?
    
   
    var userinfo:UserInfo?

    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        //image counting
        return main_menu_imgs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        // put image
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! CustomCell
        
        cell.menuImage.image = main_menu_imgs[indexPath.row]
        cell.iconImage.image = main_menu_icons[indexPath.row]
        cell.label.text = main_menu_strs[indexPath.row]
        
        if(UIDevice.current.userInterfaceIdiom == .pad){
            cell.label.font = cell.label.font.withSize(25)
        }
        
        cell.label.textColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
             PreparingToLaunch(vc: self).show()
        case 1:
             PreparingToLaunch(vc: self).show()
        case 2:
            performSegue(withIdentifier: "seat", sender: nil)
        case 3:
            performSegue(withIdentifier: "calendar", sender: nil)
            break;
        case 4:
           // performSegue(withIdentifier: "dish", sender: nil)
            PreparingToLaunch(vc: self).show()
            break;
        case 5:
            performSegue(withIdentifier: "delivery", sender: nil)
            break;
        case 6:
//            webView.loadRequest(URLRequest(url:URL(string: urlPortalLogin)!))
            PreparingToLaunch(vc: self).show()
            break;
        case 7:
            performSegue(withIdentifier: "chat", sender: nil)
            break;
        case 8:
            if stateLogin{
                performSegue(withIdentifier: "lms", sender: nil)
            }
            break;
            
        default:
            break;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(UIDevice.current.userInterfaceIdiom == .phone){
            
            //iphone
            
            let width = collectionView.frame.width/3 - 1
            
            return CGSize(width: width, height: width)
            
        } else {
            
            //ipad
            
            let width = collectionView.frame.width/4 - 1
            
            return CGSize(width: width, height: width)
            
        }
        
        
      
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //  행 하단 여백
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 컬럼 여백
        return 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserInfo()
        
        viewInit()
        
        initRevealView()
    }
    
    public func getUserInfo(){
        let decoded  = UserDefaults.standard.object(forKey: "key1") as! Data
        userinfo = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserInfo

        if userinfo?.username != "guest" {
            
            print("tagg userid : \(userinfo?.username) pw: \(userinfo?.pw)")
            
            webView.loadRequest(URLRequest(url:URL(string: urlMyLMS)!))
            
        }
    }
    
    func viewInit(){
                
        self.navigationItem.leftBarButtonItem?.tintColor = blueInspireColor
        
        //remove border
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //remove back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        navMenuButton.target = self.revealViewController()
        navMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
   
        //set RevealView Event
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        bgrClickEvent()
    }
    
    func initRevealView(){
        
        if positionValue != nil{
            performSegue(withIdentifier: positionValue!, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       if segue.identifier == "로그아웃"{
            UserDefaults.standard.set(nil, forKey: "key1")
            
            CookieAndCache().removeAll()
        
            isLogout = true
            webView.loadRequest(URLRequest(url: URL(string: urlLMSLogin)!))
       }else{
        
            NavMenuController().webRedirect(segue: segue)
        
        }
    }
    
    @IBOutlet weak var imageBgr: UIImageView!
    func bgrClickEvent(){
//        imageBgr.isUserInteractionEnabled = true
//        imageBgr.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("buttonTapped")))
    }
    
//    @objc func buttonTapped(){
//        performSegue(withIdentifier: "login", sender: nil)
//    }

    @IBOutlet weak var webView: UIWebView!
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print("tagg",request.url)
        
        if request.url?.absoluteString == "https://www.kau.ac.kr/page/login.jsp?target_page=act_Lms_Check.jsp@chk1-1&refer_page="  {
            
            LoginFailAlert(vc:self).show()
            
            return false
            
        }
//        else if request.url?.absoluteString == urlMyLMS{
//
//            stateLogin = true
//
//            return false
//
//        }
        
        return true
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView){
        
        print("tagg didfinished", webView.request?.url?.absoluteString)
        
        if webView.request?.url?.absoluteString == urlMyPortal{
            performSegue(withIdentifier: "시간표", sender: nil)
        }
        
        else if  (webView.request?.url?.absoluteString == urlLMSLogin && !isLogout) || webView.request?.url?.absoluteString == urlKAULogin {
            
            print("tagg let put my account")
            
            let loadUsernameJS = "document.getElementsByName('p_id')[0].value = \'\(userinfo?.username as! String)\';"
            
            let loadPasswordJS = "document.getElementsByName('p_pwd')[0].value = \'\(userinfo?.pw as! String)\';"
            
            let onClickEventJS =  "var cells = document.getElementsByTagName('img');" + "for(var i=0; i < cells.length; i++){ var status = cells[i].getAttribute('alt');if(status=='로그인버튼'){ cells[i].click(); break;} }"
            
            self.webView.stringByEvaluatingJavaScript(from: loadUsernameJS)
            self.webView.stringByEvaluatingJavaScript(from: loadPasswordJS)
            self.webView.stringByEvaluatingJavaScript(from: onClickEventJS)
        }
        else if (webView.request?.url?.absoluteString == "https://www.kau.ac.kr/page/act_Lms_Check.jsp@chk1-1 "){
            stateLogin = true
        }
        
        else if webView.request?.url?.absoluteString == urlMyLMS {
            
             stateLogin = true
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

class CustomCell:UICollectionViewCell{
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    
}



