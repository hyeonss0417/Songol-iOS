//
//  LoginViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 5..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController,UIWebViewDelegate {
    
    private var dbRef : DatabaseReference! // 인스턴스 변수
    
    private var isLogin = 0
    
    private let log:String = "LogTag"
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var labelID: UITextField!
    
    @IBOutlet weak var labelPW: UITextField!
    
    @IBAction func guestButtonOnClick(_ sender: Any) {
        performSegue(withIdentifier: "guestLogin", sender: nil)
    }
    
    var userID:String?
    var userPW:String?
    var uid:String?
    
    @IBAction func LoginButtonOnClick(_ sender: Any) {

        if labelID.text == nil || labelPW.text == nil{
            let alertController = UIAlertController(title: "로그인 실패",message: "ID/PW 를 모두 입력하십시오.", preferredStyle: UIAlertControllerStyle.alert)
            
            //UIAlertActionStye.destructive 지정 글꼴 색상 변경
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
            }
            
            alertController.addAction(okAction)
            
            self.present(alertController,animated: true,completion: nil)
        }else{
            userID = labelID.text
            userPW = labelPW.text
            
            let url = URL(string: stringURL)
            webView.loadRequest(URLRequest(url: url!))
        }
    }
    
//    let stringURL :String = "https://www.kau.ac.kr/page/login.jsp?target_page=main.jsp&refer_page="

    let stringURL : String = "https://www.kau.ac.kr/page/login.jsp?target_page=act_Lms_Check.jsp@chk1-1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       CookieAndCache().removeAll()
        
        initView()
    }
    
    func initView(){
        labelID.placeholder = "Portal ID"
        labelPW.placeholder = "Portal PW"
        dbRef = Database.database().reference()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if request.url?.absoluteString == "https://www.kau.ac.kr/page/login.jsp?target_page=act_Lms_Check.jsp@chk1-1&refer_page=" {
            
            isLogin = 2
            
            LoginFailAlert(vc:self).show()
            
            return false;
            
        }else if request.url?.absoluteString == "http://lms.kau.ac.kr/my/"{
            
            isLogin = 1
            
            firebaseLoginWithEmail()

            return false;
        }
        
        return true
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView){
        
        if  webView.request?.url?.absoluteString == stringURL{

            let loadUsernameJS = "document.getElementsByName('p_id')[0].value = \'\(userID!)\';"

            let loadPasswordJS = "document.getElementsByName('p_pwd')[0].value = \'\(userPW!)\';"
            
            let onClickEventJS =  "var cells = document.getElementsByTagName('img');" + "for(var i=0; i < cells.length; i++){ var status = cells[i].getAttribute('alt');if(status=='로그인버튼'){ cells[i].click(); break;} }"
            
            self.webView.stringByEvaluatingJavaScript(from: loadUsernameJS)
            self.webView.stringByEvaluatingJavaScript(from: loadPasswordJS)
            self.webView.stringByEvaluatingJavaScript(from: onClickEventJS)

        }
    }
    
    func firebaseLoginWithEmail(){
        
        Auth.auth().signIn(withEmail: labelID.text!+"@kau.ac.kr", password: labelPW.text!) { (user, error) in
            if user != nil{//login success
                self.readUserInfo(uid: (Auth.auth().currentUser?.uid)!)
             //   self.performSegue(withIdentifier: "selectMajor", sender: nil)
            }else{//login failed
                print("login failed!")
                print(error)
                self.firebaseCreateUserWithEmail(count: 0)
            }
        }
    }
    
    func readUserInfo(uid: String){
        
        dbRef.child("Users/"+uid).observe(.value, with: {(snapshot) in
            
            var userinfo =  [String]()
            
            for child in snapshot.children{
                let data = child as! DataSnapshot
                userinfo.append(data.value as! String)
            }
            
            var userInfo = UserInfo(uid: uid, major: userinfo[0], pw: self.userPW, snumber: userinfo[2], username: self.userID)

        AccountInfo().storeUserInfo(userInfo: userInfo)
        

        self.performSegue(withIdentifier: "SWReveal", sender: nil)

        }){(error) in
            print(error.localizedDescription)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "selectMajor" {
            if let destinationVC = segue.destination as? SelectMajorViewController {
                destinationVC.setUserData(uid: uid!, username: labelID.text!, password: labelPW.text!)
            }
        }else if segue.identifier == "guestLogin" {
            AccountInfo().storeUserInfo(userInfo: UserInfo(uid: "", major: "", pw: "", snumber:"0000", username:"guest"))
        }
    }


    func firebaseCreateUserWithEmail(count: Int){
        var temp:String = ""
        if count != 0 {
            temp = temp + String(count)
        }
        
        Auth.auth().createUser(withEmail: self.labelID.text!+temp+"@kau.ac.kr", password: self.labelPW.text!+temp) { (user, error) in
                
            if user !=  nil{//register success
                print("success!")
                self.uid = Auth.auth().currentUser?.uid
                self.performSegue(withIdentifier: "selectMajor", sender: nil)
            }else if count < 10 {// failed
                print("create failed!")
                self.firebaseCreateUserWithEmail(count: count+1)
            }
        }
    }
    
    func getCookies(){
        let cookieStorage = HTTPCookieStorage.shared
        let cookies = cookieStorage.cookies as! [HTTPCookie]
        
        var jsessionID: HTTPCookie?
        
        print("tagg Cookies.count: \(cookies.count)")
        for cookie in cookies {
            print("tagg name: \(cookie.name) value: \(cookie.value)")
            if cookie.name == "JSESSIONID"{
                jsessionID = cookie
            }
            
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

