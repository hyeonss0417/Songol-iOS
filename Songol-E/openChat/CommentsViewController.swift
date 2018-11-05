//
//  CommentsViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 19..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CommentsViewController : BaseUIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
        
    struct commentData{
        var iconImage = UIImage()
        var username = String()
        var date = String()
        var text = String()
    }
    
    @IBOutlet weak var bottomView: UIView!
    
    private var keyBoardState = 0
    
    private var parentData : OpenChatParentViewController.parentCellData?
    private var preVC: OpenChatParentViewController?
    private var dbRef : DatabaseReference! // 인스턴스 변수
    
    private var userinfo : UserInfo?
    private var chatTableViewData : [commentData] = []
    private var index = 0
    
    @IBOutlet weak var imgParenticon: UIImageView!
    @IBOutlet weak var labelParentUserName: UILabel!
    @IBOutlet weak var labelParentDate: UILabel!
    @IBOutlet weak var labelParentContent: UILabel!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var imgMyIcon: UIImageView!
    @IBOutlet weak var textComments: UITextField!
    
    @IBAction func SubmitBtnOnClicked(_ sender: Any) {
        if textComments.text != "" && textComments.text != nil{
            
              YesOrNoAlert(vc: self, title: "게시 확인", msg: "작성한 글을 게시하시겠습니까?").show()
            
        }
    }
    
    override func callback() {
        let currentTime = Int(round( NSDate().timeIntervalSince1970 * 1000))
        
        dbRef.child("Questions").child(String(parentData?.timeInterval as! Int)).observeSingleEvent(of: .value, with: {(snapshot) in
            
            let value = (snapshot as! DataSnapshot).value as? NSDictionary
            
            let childCnt = value?["numofcom"] as! Int
            
            self.dbRef.child("Questions").child(String(self.parentData?.timeInterval as! Int)).updateChildValues(["numofcom":childCnt+1])
            
            print("---", childCnt)
            
        }){(error) in
            print(error.localizedDescription)
        }
        
        dbRef.child("Child").child(String(parentData?.timeInterval as! Int)).child(String(currentTime)).setValue(["date":currentTime, "numofcom":0, "snum":userinfo?.snumber, "text": textComments.text, "type":1])
//
//        // dismiss alert & self
        
        preVC?.readChatList()
        
        self.navigationController?.popViewController(animated: true)
    }
   
    
    func setParentData(parentData: OpenChatParentViewController.parentCellData, preVC: OpenChatParentViewController){
        self.parentData = parentData
        self.preVC = preVC
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewChildCell", for: indexPath) as! ChatTableViewChildCell
        
        let chatData = chatTableViewData[indexPath.row]
        
        cell.labelChildDate.text = chatData.date
        cell.imgChildIcon.image = chatData.iconImage
        cell.labelChildContent.text = chatData.text
        cell.labelChildContent.sizeToFit()
        cell.labelChildUserName.text = chatData.username
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return chatTableViewData.count
        return self.index
    }
    
    func readChildList(){
        
        dbRef.child("Child").child(String(parentData?.timeInterval as! Int)).observeSingleEvent(of: .value, with: {(snapshot) in
            
            for child in snapshot.children{
                let value = (child as! DataSnapshot).value as? NSDictionary
                
                let iconImage = AccountInfo().userIconSelection(snum: value?["snum"] as! String)
                
                let username = AccountInfo().usernameSelection(snum: value?["snum"] as! String)
                
                let date = self.dateToStringFormat(date:
                    NSDate(timeIntervalSince1970: (value?["date"] as! TimeInterval)/1000))
                
                let childCellDataModel = commentData(iconImage: iconImage, username: username, date: date, text: value?["text"] as! String)
                
                self.chatTableViewData.append(childCellDataModel)
            }
            
            if self.chatTableViewData.count > 0{
                for index in 0...self.chatTableViewData.count-1 {
                    self.index = index+1
                    self.mTableView.insertRows(at: [IndexPath(row: self.index-1, section: 0)],  with: UITableViewRowAnimation.automatic)
                }
            }
            
        }){(error) in
        print(error.localizedDescription)
        }
        
    }
    
    func dateToStringFormat(date: NSDate) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatterGet.string(from: date as Date)
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "댓글"
        
        dbRef = Database.database().reference()
        
        initView()
        
        readChildList()
        
    }
    
    func initView(){
        
        textComments.delegate = self
        
        mTableView.allowsSelection = false
        
        imgParenticon.image = parentData?.iconImage
        labelParentDate.text = parentData?.date
        labelParentContent.text = parentData?.text
        labelParentUserName.text = parentData?.username
        
        userinfo = AccountInfo().getUserInfo()
        
        imgMyIcon.image = AccountInfo().userIconSelection(snum: (userinfo?.snumber)!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        mTableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("TableTapped")))
        
    }
    
    @objc func TableTapped(){
          self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if keyBoardState == 0 {
                keyBoardState = 1
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if keyBoardState == 1 {
                keyBoardState = 0
                self.view.frame.origin.y += keyboardSize.height
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
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
}

class ChatTableViewChildCell: UITableViewCell{
    
    @IBOutlet weak var imgChildIcon: UIImageView!
    
    @IBOutlet weak var labelChildUserName: UILabel!
    
    @IBOutlet weak var labelChildDate: UILabel!
    
    @IBOutlet weak var labelChildContent: UILabel!
    
}
