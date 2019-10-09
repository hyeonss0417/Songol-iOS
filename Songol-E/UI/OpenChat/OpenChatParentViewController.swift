//
//  OpenChatParentViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 21..
//  Copyright © 2018년 최민섭. All rights reserved.
//
import UIKit
import Firebase
import FirebaseDatabase

class OpenChatParentViewController: UITableViewController{
    struct parentCellData{
        var username = String()
        var date = String()
        var text = String()
        var numOfChild = Int()
        var timeInterval = Int()
    }
    
    private let log:String = "LogTag"
    private var parentCellIndex = 0
    private var refControl: UIRefreshControl?
    private let loadingDialog = LoadingDialog()
    var chatTableViewData : [parentCellData] = []
    var dbRef : DatabaseReference! // 인스턴스 변수
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatTableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentCellIndex = indexPath.row
        performSegue(withIdentifier: "comments", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewParentCell", for: indexPath) as! ChatTableViewParentCell
        let chatData = chatTableViewData[indexPath.row]
        
        cell.labelDate.text = chatData.date
        cell.labelComments.text = String(chatData.numOfChild) + "개의 댓글"
        cell.labelContent.text = chatData.text
        cell.labelContent.sizeToFit()
        cell.labelUserName.text = chatData.username
        
        return cell
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadingDialog.displaySpinner(on: self.view)
        
        self.title = "오픈 채팅"
        
        dbRef = Database.database().reference()
        
        self.tableView?.separatorColor = .clear
    
        readChatList()
        
        initwriteButton()
        
        initRefreshControl()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for row in tableView?.indexPathsForSelectedRows ?? [] {
            tableView?.deselectRow(at: row, animated: true)
        }
    }
    
    func initwriteButton(){
        let write = UIBarButtonItem(title: "글쓰기", style: .plain, target: self, action: Selector("wrtieButtonTapped"))
        self.navigationItem.rightBarButtonItems = [write]
    }
    
    func initRefreshControl(){
        refControl = UIRefreshControl()
        refControl?.addTarget(self, action: Selector("refresh"), for: .valueChanged)
        tableView?.refreshControl = refControl
    }
    
    @objc func refresh() {
        readChatList()
    }

    @objc func wrtieButtonTapped() {
          performSegue(withIdentifier: "post", sender: nil)
    }
    
    func readChatList(){
        dbRef.child("Chat").observeSingleEvent(of: .value, with: {(snapshot) in
            let now = NSDate()
            var datas: [parentCellData] = []
            
            for child in snapshot.children{
                guard let value = (child as! DataSnapshot).value as? NSDictionary else {return}
                
                guard let dateValue = value["date"] as? TimeInterval else {return}
                let date = dateValue.formattedStringFromNow(now: now)
                
                let childCount = value["numOfCom"] as! Int
                
                let parentCellDataModel = parentCellData(username: "항대익명", date: date, text: value["text"] as! String, numOfChild: childCount, timeInterval : value["date"] as! Int)
                
                datas.append(parentCellDataModel)
            }

            datas.reverse()
            
            self.chatTableViewData = datas

            DispatchQueue.main.async {
                self.tableView?.refreshControl?.endRefreshing()
                self.loadingDialog.removeSpinner()
                UIView.animate(withDuration: 0.5, animations: {
                    self.tableView.reloadData()
                })
            }
        }){(error) in
            print(error.localizedDescription)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comments" {
            if let destinationVC = segue.destination as? CommentsViewController {
                destinationVC.setParentData(parentData: chatTableViewData[parentCellIndex], preVC: self)
            }
        }else if segue.identifier == "post" {
            if let destinationVC = segue.destination as? PostViewController {
                destinationVC.setPreVC(preVC: self)
            }
        }
    }
    
}

class ChatTableViewParentCell: UITableViewCell{
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var labelComments: UILabel!
    
}
