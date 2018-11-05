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

class LoginViewController: UIViewController,UIWebViewDelegate, UITextFieldDelegate {
    
    private var dbRef : DatabaseReference! // 인스턴스 변수
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var labelID: UITextField!
    
    @IBOutlet weak var labelPW: UITextField!
    
    private var loadingDialog:AnyObject?
    
    @IBAction func guestButtonOnClick(_ sender: Any) {
                
        labelID.text = "guest"
        labelPW.text = "111111"
        
        firebaseLoginWithEmail()
        
    }
    
    var userID:String?
    var userPW:String?
    var uid:String?
    
    @IBAction func LoginButtonOnClick(_ sender: Any) {

        if labelID.text == nil || labelPW.text == nil{
            
            FormNotFilledAlert(vc:self).show()
            
        }else{
            
            loadingDialog = LoadingDialog().displaySpinner(onView: self.view)
            
            userID = labelID.text
            userPW = labelPW.text
            
            webView.loadRequest(URLRequest(url: URL(string: urlLMSLogin)!))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelID.delegate = self
        labelPW.delegate = self
        
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
            
            LoginFailAlert(vc:self).show()
            
            LoadingDialog().removeSpinner(spinner: self.loadingDialog as! UIView)
            
            return false;
            
        }else if request.url?.absoluteString == urlMyLMS{
            
            firebaseLoginWithEmail()

            return false;
        }
        
        return true
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView){
        
        if  webView.request?.url?.absoluteString == urlLMSLogin{

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
                
                if self.labelID.text == "guest"{
                    self.performSegue(withIdentifier: "guestLogin", sender: nil)
                }else{
                
                    self.readUserInfo(uid: (Auth.auth().currentUser?.uid)!)
                
                }
                
            }else{//login failed
                
                print("login failed!")
                print(error)
                self.firebaseCreateUserWithEmail(count: 0)
                
            }
        }
    }
    
    func readUserInfo(uid: String){
        
        dbRef.child("Users/"+uid).observeSingleEvent(of: .value, with: {(snapshot) in
            
            var userinfo =  [String]()
            
            for child in snapshot.children{
                let data = child as! DataSnapshot
                userinfo.append(data.value as! String)
            }
            
            var userInfo = UserInfo(uid: uid, major: userinfo[0], pw: self.userPW, snumber: userinfo[2], username: self.userID)

        AccountInfo().storeUserInfo(userInfo: userInfo)
        
        
        self.performSegue(withIdentifier: "SWReveal", sender: nil)
            
        LoadingDialog().removeSpinner(spinner: self.loadingDialog as! UIView)

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
                
                self.uid = Auth.auth().currentUser?.uid
                
                self.performSegue(withIdentifier: "selectMajor", sender: nil)
                
                LoadingDialog().removeSpinner(spinner: self.loadingDialog as! UIView)
                
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

