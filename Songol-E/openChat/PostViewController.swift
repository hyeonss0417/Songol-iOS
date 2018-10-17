//
//  PostViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 15..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class PostViewController: UIViewController{
    
    @IBAction func PostButtonOnClick(_ sender: Any) {
    }
    
    @IBOutlet weak var textContent: UITextField!
    @IBOutlet weak var labelUser: UILabel!
    @IBOutlet weak var imgUserIcon: UIImageView!
    
    var userinfo:UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        userinfo = AccountInfo().getUserInfo()
        
        initView()
    
    }
    
    
    func initView(){
//
//        labelUser.text = AccountInfo().usernameSelection(snum: (userinfo?.snumber)!)
//        imgUserIcon.image =
//            AccountInfo().userIconSelection(snum: (userinfo?.snumber)!)
//
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
