//
//  SelectMajorViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 7..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import SwiftSoup
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SelectMajorViewController: UIViewController {
    
    var preSelectedBtn: UIButton?
    var username, password:String?
    var userInfo:UserInfo?
    var major : String?
    var uid:String?
    var snum:String?
    private var dbRef : DatabaseReference! // 인스턴스 변수
    
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
            
            performSegue(withIdentifier: "iconselector", sender: self)

        }
        
       
    }
    
    public func setUserData(uid:String, username: String, password:String){
        self.uid = uid
        self.username = username
        self.password = password
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "iconselector"{
            let dest = segue.destination as! IconSelectPopUp
            dest.setMajorVCInstance(majorVC: self)
        }
    }
    
    public func setSnumber(snum:String){
        
        self.snum = snum
        
        userInfo = UserInfo(uid:uid!, major: major!, pw: password!, snumber: snum , username: username!)
        
        AccountInfo().storeUserInfo(userInfo: userInfo!)
        
        uploadUserDataToDB()
        
    }
    
    func uploadUserDataToDB(){
        
        self.dbRef.child("Users").child(uid!).setValue(["major":major!, "pw":password!, "snumber":snum, "username": username! ])
        
        performSegue(withIdentifier: "SWRevealWithSignin", sender: nil)
        
    }
    
    override func viewDidLoad() {
        
         dbRef = Database.database().reference()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
