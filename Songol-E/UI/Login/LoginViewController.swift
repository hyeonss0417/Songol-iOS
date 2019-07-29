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
import WebKit

class LoginViewController: UIViewController {
    @IBOutlet weak var webKit: WKWebView!
    @IBOutlet weak var labelID: UITextField!
    @IBOutlet weak var labelPW: UITextField!
    private var userID:String?
    private var userPW:String?
    private var dbRef = Database.database().reference() // 인스턴스 변수
    private let dialog = LoadingDialog()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelID.delegate = self
        labelPW.delegate = self
        webKit.navigationDelegate = self
        
        //clear UserDefault DB
        UserDefaults.standard.set(nil, forKey: "key1")

    }
    
    @IBAction func guestButtonOnClick(_ sender: Any) {
        
        labelID.text = "guest"
        labelPW.text = "111111"
        firebaseLoginWithEmail()
        
    }
    
    @IBAction func LoginButtonOnClick(_ sender: Any) {

        if labelID.text == nil || labelPW.text == nil{
            
            FormNotFilledAlert(vc:self).show()
            
        }else{
            
            userID = labelID.text
            userPW = labelPW.text
            
            webKit.loadWithStringUrl(url: UrlLmsLogin1)
            dialog.displaySpinner(on: self.view)
        }
    }
    
    func firebaseLoginWithEmail(){
        
        Auth.auth().signIn(withEmail: labelID.text!+"@kau.ac.kr", password: labelPW.text!) { (user, error) in
            if user != nil{//login success
                self.authOnSuccess(type: (self.labelID.text == "guest") ? UserType.guest : UserType.normal )
                
            }else{//login failed
                self.firebaseCreateUserWithEmail(count: 0)
            }
        }
    }
    
    func firebaseCreateUserWithEmail(count: Int){
        var temp:String = ""
        if count != 0 {
            temp = temp + String(count)
        }
        
        Auth.auth().createUser(withEmail: "\(self.labelID.text!)\(temp)@kau.ac.kr", password: "\(self.labelPW.text!)\(temp)") { (user, error) in
                
            if user !=  nil{//register success
                self.authOnSuccess(type: UserType.normal)
            }else if count < 100 {// failed
                self.firebaseCreateUserWithEmail(count: count+1)
            }
        }
    }
    
    func authOnSuccess(type: UserType){
        
        var userInfo: UserInfo
        
        switch type {
        case .guest:
            userInfo = UserInfo(uid: "", major: "", pw: "", snumber:"0000", username:"guest")
            break
        case .normal, .songol:
            userInfo = UserInfo(uid: "", major: "", pw: self.userPW, snumber: "", username: self.userID)
            break
        }
        
        AccountInfo().storeUserInfo(userInfo: userInfo)
        self.performSegue(withIdentifier: "login", sender: nil)
        dialog.removeSpinner()
    }
    
  
}

extension LoginViewController: UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension LoginViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        let currentUrl = webView.url!.absoluteString
        switch currentUrl {
        case UrlLmsLogin1, UrlLmsLogin2:
            CommonUtils().macroKauLogin(on: webKit, id: userID!, pw: userPW!)
            break
        case UrlLmsLoginSuccess:
            //LoginSuccess
            firebaseLoginWithEmail()
            authOnSuccess(type: .normal)
            break
        case UrlLMSLoginFail:
            dialog.removeSpinner()
            CommonUtils().alertLoginFail(on: self)
            break
        default:
            break
        }
    }
}
