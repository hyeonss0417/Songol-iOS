//
//  PostViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 15..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostViewController: BaseUIViewController{
    
    private var dbRef : DatabaseReference! // 인스턴스 변수
    
    private var userinfo:UserInfo?
    private var preVC: OpenChatParentViewController?
    
    @IBAction func PostButtonOnClick(_ sender: Any) {
        
        if textContent.text != "" {
            YesOrNoAlert(vc: self, title: "게시 확인", msg: "작성한 글을 게시하시겠습니까?").show()
        }
        
    }
    
    public func setPreVC(preVC: OpenChatParentViewController){
        self.preVC = preVC
    }
    
    override func callback() {
        
        let currentTime = Int(round( NSDate().timeIntervalSince1970 * 1000))
    dbRef.child("Questions").child(String(currentTime)).setValue(["date":currentTime, "numofcom":0, "snum":userinfo?.snumber, "text": textContent.text, "type":0])
        
        preVC?.readChatList()
        
        // dismiss alert & self
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBOutlet weak var textContent: UITextField!
    @IBOutlet weak var labelUser: UILabel!
    @IBOutlet weak var imgUserIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        userinfo = AccountInfo().getUserInfo()
        
        initView()
        
        dbRef = Database.database().reference()
    
    }
    
    func initView(){

        labelUser.text = AccountInfo().usernameSelection(snum: (userinfo?.snumber)!)
        imgUserIcon.image =
            AccountInfo().userIconSelection(snum: (userinfo?.snumber)!)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
