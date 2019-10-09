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
        var username = String()
        var date = String()
        var text = String()
    }
    
    @IBOutlet weak var bottomView: UIView!  {
        didSet {
            bottomViewOriginY = bottomView.bounds.origin.y
        }
    }
    
    private var keyBoardState = 0
    
    private var parentData : OpenChatParentViewController.parentCellData?
    private var preVC: OpenChatParentViewController?
    private var dbRef : DatabaseReference! // 인스턴스 변수
    
    private var userinfo : UserInfo?
    private var chatTableViewData : [commentData] = []
    
    @IBOutlet weak var imgParenticon: UIImageView!
    @IBOutlet weak var labelParentUserName: UILabel!
    @IBOutlet weak var labelParentDate: UILabel!
    @IBOutlet weak var labelParentContent: UILabel!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var imgMyIcon: UIImageView!
    @IBOutlet weak var textComments: UITextField!
    private var bottomViewOriginY: CGFloat!
    
    
    @IBAction func SubmitBtnOnClicked(_ sender: Any) {
        if textComments.text != "" && textComments.text != nil{
              YesOrNoAlert(vc: self, title: "게시 확인", msg: "작성한 글을 게시하시겠습니까?").show()
        }
    }
    
    override func callback() {
        let currentTime = Int(round( NSDate().timeIntervalSince1970 * 1000))
        
        dbRef.child("Chat").child(String(parentData?.timeInterval as! Int)).observeSingleEvent(of: .value, with: {(snapshot) in
            
            let value = (snapshot as! DataSnapshot).value as? NSDictionary
            
            let childCnt = value?["numOfCom"] as! Int
            
            self.dbRef.child("Chat").child(String(self.parentData?.timeInterval as! Int)).updateChildValues(["numOfCom":childCnt+1])
            
        }){(error) in
            print(error.localizedDescription)
        }
        
        dbRef.child("ChatChild").child(String(parentData?.timeInterval as! Int)).child(String(currentTime)).setValue(["date":currentTime,"like": false, "numOfCom":0, "numOfLikes": 0,"snum":userinfo?.username, "text": textComments.text, "type":1])
        
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
        cell.labelChildContent.text = chatData.text
        cell.labelChildContent.sizeToFit()
        cell.labelChildUserName.text = chatData.username
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatTableViewData.count
    }
    
    func readChildList(){
        dbRef.child("ChatChild").child(String(parentData?.timeInterval as! Int)).observeSingleEvent(of: .value, with: {(snapshot) in
            let now = NSDate()
            var indexPaths = [IndexPath]()
            
            for child in snapshot.children{
                guard let value = (child as! DataSnapshot).value as? NSDictionary else {return}
                guard let dateValue = value["date"] as? TimeInterval else {return}
                
                let date = dateValue.formattedStringFromNow(now: now)
                
                let childCellDataModel = commentData( username: "항대익명", date: date, text: value["text"] as! String)
                
                self.chatTableViewData.append(childCellDataModel)
            }
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: {
                    self.mTableView.reloadSections(IndexSet(0...0), with: .fade)
                })
            }
        }){print($0.localizedDescription)}
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
        
        labelParentDate.text = parentData?.date
        labelParentContent.text = parentData?.text
        labelParentUserName.text = parentData?.username
        
        userinfo = AccountInfo().getUserInfo()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("TableTapped")))
        
    }
    
    @objc func TableTapped(){
          self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo:NSDictionary = notification.userInfo as NSDictionary? else {return}
        
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        if #available(iOS 11.0, *) {
            self.bottomView.bounds.origin.y = bottomViewOriginY + keyboardHeight - self.view.safeAreaInsets.bottom
        } else {
            self.bottomView.bounds.origin.y = bottomViewOriginY + keyboardHeight - 0
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.bottomView.bounds.origin.y = bottomViewOriginY
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
