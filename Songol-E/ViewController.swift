//
//  ViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 8. 30..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIWebViewDelegate {
    
    private var isLogin = 0
    private var isLogout = false
    
    let blueInspireColor = UIColor(red: 34/255.0, green: 45/255.0, blue: 103/255.0, alpha: 1.0)
    
    let stringURL :String = "https://www.kau.ac.kr/page/login.jsp?target_page=act_Lms_Check.jsp@chk1-1"
    
    @IBOutlet weak var navMenuButton: UIBarButtonItem!
    
    var positionValue : String?
    var currentViewController : ViewController?
    
    let imgs_menu = [#imageLiteral(resourceName: "main_board_"), #imageLiteral(resourceName: "main_board_major_"), #imageLiteral(resourceName: "main_library_seat_"), #imageLiteral(resourceName: "main_calendar_"), #imageLiteral(resourceName: "main_dish_"), #imageLiteral(resourceName: "main_delivery_"), #imageLiteral(resourceName: "main_time_table_"), #imageLiteral(resourceName: "main_chat_"), #imageLiteral(resourceName: "main_lms")]
    let icons_menu = [#imageLiteral(resourceName: "main_board_icon"), #imageLiteral(resourceName: "main_board_major_icon"), #imageLiteral(resourceName: "main_library_seat_icon"), #imageLiteral(resourceName: "main_calendar_icon"), #imageLiteral(resourceName: "main_dish_icon"), #imageLiteral(resourceName: "main_delivery_icon"), #imageLiteral(resourceName: "main_time_table_icon"), #imageLiteral(resourceName: "main_chat_icon"), #imageLiteral(resourceName: "main_lms_icon")]
    let str_menu = ["게시판","과별 게시판", "열람실 좌석현황", "학사 일정", "식단표", "배달음식", "시간표", "오픈 채팅","LMS"]
    
    var userinfo:UserInfo?

    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        //image counting
        return imgs_menu.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        // put image
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! CustomCell
        
        cell.menuImage.image = imgs_menu[indexPath.row]
        cell.iconImage.image = icons_menu[indexPath.row]
        cell.label.text = str_menu[indexPath.row]
        cell.label.textColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 2:
            performSegue(withIdentifier: "seat", sender: nil)
        case 3:
            performSegue(withIdentifier: "calendar", sender: nil)
            break;
        case 4:
           // performSegue(withIdentifier: "dish", sender: nil)
            break;
        case 5:
            performSegue(withIdentifier: "delivery", sender: nil)
            break;
        case 7:
            performSegue(withIdentifier: "chat", sender: nil)
            break;
        case 8:
            performSegue(withIdentifier: "lms", sender: nil)
            break;
            
        default:
            break;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width/3 - 1
        
        return CGSize(width: width, height: width)
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
            
            let url = URL(string: stringURL)
            webView.loadRequest(URLRequest(url: url!))
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
        if segue.identifier == "동아리"{
            if let destinationVC = segue.destination as? WebInfoViewController {
                destinationVC.setWebInfo(barTitle: "동아리 정보", url: "http://www.kau.ac.kr/onestopservice/soss_student_group_aero.html")
            }
        }
//        else if segue.identifier == "화전역 열차 시간표"{
//            if let destinationVC = segue.destination as? WebInfoViewController {
//                destinationVC.setWebInfo(barTitle: "화전역 열차 시간표", url: "https://m.search.naver.com/search.naver?query=%ED%99%94%EC%A0%84%EC%97%AD&where=m&sm=mtp_hty")
//            }
//        }
        else if segue.identifier == "도서관 도서 검색"{
            if let destinationVC = segue.destination as? WebInfoViewController {
                destinationVC.setWebInfo(barTitle: "도서관 도서 검색", url: "http://lib.kau.ac.kr/HAULMS/SlimaDL.csp?HLOC=HAULMS&COUNT=2kij25cp00&Kor=1&frmDLL=frmDLL.csp?Left=Left02&frmDLR=Search/SearchC.csp?Gate=DA")
            }
        }else if segue.identifier == "스터디룸 예약현황"{
            if let destinationVC = segue.destination as? WebInfoViewController {
                destinationVC.setWebInfo(barTitle: "스터디룸 예약현황", url: "http://lib.kau.ac.kr/haulms/haulms/SRResv.csp")
            }
        }else if segue.identifier == "교직원 정보"{
         
            if let destinationVC = segue.destination as? WebInfoViewController {
                destinationVC.setWebInfo(barTitle: "교직원 정보", url: "http://www.kau.ac.kr/page/faculty/staff.jsp")
            }
            
        }else if segue.identifier == "로그아웃"{
            UserDefaults.standard.set(nil, forKey: "key1")
            
            CookieAndCache().removeAll()
            
            let url = URL(string: stringURL)
            isLogout = true
            webView.loadRequest(URLRequest(url: url!))
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
    
    var check = 0
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        //print("tagg",request.url)
        
        if request.url?.absoluteString == "https://www.kau.ac.kr/page/login.jsp?target_page=act_Lms_Check.jsp@chk1-1&refer_page="  {
            
            isLogin = 2
            
            LoginFailAlert(vc:self).show()
            
            return false;
        }else if request.url?.absoluteString == "http://lms.kau.ac.kr/my/"{
            isLogin = 1
            return false;
        }
        
        return true
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView){
        
        if  webView.request?.url?.absoluteString == stringURL && !isLogout{
            
            //print("tagg let put my account")
            
            let loadUsernameJS = "document.getElementsByName('p_id')[0].value = \'\(userinfo?.username as! String)\';"
            
            let loadPasswordJS = "document.getElementsByName('p_pwd')[0].value = \'\(userinfo?.pw as! String)\';"
            
            let onClickEventJS =  "var cells = document.getElementsByTagName('img');" + "for(var i=0; i < cells.length; i++){ var status = cells[i].getAttribute('alt');if(status=='로그인버튼'){ cells[i].click(); break;} }"
            
            self.webView.stringByEvaluatingJavaScript(from: loadUsernameJS)
            self.webView.stringByEvaluatingJavaScript(from: loadPasswordJS)
            self.webView.stringByEvaluatingJavaScript(from: onClickEventJS)
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



