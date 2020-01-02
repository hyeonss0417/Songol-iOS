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

protocol LoginCoordinatorDelegate {
    func main()
}

class LoginViewController: UIViewController {
    @IBOutlet weak var labelID: UITextField!
    @IBOutlet weak var labelPW: UITextField!
    private var userID:String?
    private var userPW:String?
    private var dbRef = Database.database().reference() // 인스턴스 변수

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelID.delegate = self
        labelPW.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UserDefaults.standard.set(nil, forKey: "user")
        CookieManager.clearCookies()
    }
    
    @IBAction func guestButtonOnClick(_ sender: Any) {
        labelID.text = "guest"
        labelPW.text = "111111"
        firebaseLoginWithEmail()
    }
    
    @IBAction func LoginButtonOnClick(_ sender: Any) {
        if labelID.text?.isEmpty ?? true || labelPW.text?.isEmpty ?? true {
            FormNotFilledAlert(vc:self).show()
        } else {
            userID = labelID.text
            userPW = labelPW.text
            
            KauLoginView().tryLogin(id: userID!, pw: userPW!, parent: self) { type, res in                
                switch res {
                case .success:
                    self.firebaseLoginWithEmail()
                case .failure:
                    LoginFailAlert.shared.show(on: self)
                }
            }
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
            userInfo = UserInfo(pw: "", username:"guest")
        case .normal, .songol:
            userInfo = UserInfo(pw: self.userPW!, username: self.userID!)
        }
        
        AccountInfo().storeUserInfo(userInfo: userInfo)
        CommonUtils.sharedInstance.replaceRootViewController(identifier: .main)
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
