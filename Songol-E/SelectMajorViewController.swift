//
//  SelectMajorViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 7..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class SelectMajorViewController: UIViewController {
    
    var preSelectedBtn: UIButton?
    var username, password:String?
    var userInfo:UserInfo?
    var major : String?
    
    func storeUserInfo(){
        //store UserInfo
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: userInfo)
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: "key1")
    }
    
    @IBAction func changeMajor(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
        preSelectedBtn?.backgroundColor = UIColor.clear
        preSelectedBtn = button
        major = button.currentTitle
        
        if  button.tag == 10 && major != nil{
            //start main viewController with User Data
            userInfo = UserInfo(major: major!, pw: password!, snumber: "have to figure out", username: username!)
            
            //have to make firebase DB 
            
            performSegue(withIdentifier: "SWReveal", sender: nil)
        }
        
        button.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        print(button.currentTitle!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SWReveal"{
            storeUserInfo()
        }
    }
    
    public func setUserData(username: String, password:String){
        self.username = username
        self.password = password
    }
    
    override func viewDidLoad() {
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
