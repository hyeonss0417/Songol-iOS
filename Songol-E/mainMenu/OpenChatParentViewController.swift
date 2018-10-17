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
    
    private let log:String = "LogTag"
    
    private var index = 0
    
    struct parentCellData{
        var iconImage = UIImage()
        var username = String()
        var date = String()
        var text = String()
        var numOfChild = Int()
    }
    
    var chatTableViewData : [parentCellData] = []
    
    var dbRef : DatabaseReference! // 인스턴스 변수
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return chatTableViewData.count
        return self.index
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(self.log, "ind??????")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewParentCell", for: indexPath) as! ChatTableViewParentCell
        
        let chatData = chatTableViewData[indexPath.row]
        
        cell.labelDate.text = chatData.date
        cell.imageIcon.image = chatData.iconImage
        cell.labelComments.text = String(chatData.numOfChild) + "개의 댓글"
        cell.labelContent.text = chatData.text
        cell.labelContent.sizeToFit()
        cell.labelUserName.text = chatData.username
        
        return cell
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "오픈 채팅"
        
        dbRef = Database.database().reference()
        
        self.tableView?.separatorColor = .clear
        
        let write = UIBarButtonItem(title: "글쓰기", style: .plain, target: self, action: Selector("wrtieButtonTapped"))
        
        self.navigationItem.rightBarButtonItems = [write]
        
        readChatList()
        
    }

    @objc func wrtieButtonTapped() {
          performSegue(withIdentifier: "post", sender: nil)
    }
    
    func readChatList(){
        
        dbRef.child("Questions").observe(.value, with: {(snapshot) in
            
            for child in snapshot.children{
                let value = (child as! DataSnapshot).value as? NSDictionary
                
                let iconImage = IconSelection().iconSelection(snum: value?["snum"] as! String)
                
                let username = AccountInfo().usernameSelection(snum: value?["snum"] as! String)
                
                let date = self.dateToStringFormat(date:
                    Date(timeIntervalSince1970: value?["date"] as! TimeInterval))
                
                let childCount = value?["numofcom"] as! Int
                
                let parentCellDataModel = parentCellData(iconImage: iconImage, username: username, date: date, text: value?["text"] as! String, numOfChild: childCount)
                
                self.chatTableViewData.append(parentCellDataModel)
                
//                self.tableView.insertRows(at: [IndexPath(row: self.chatTableViewData.count-1, section: 0)],  with: UITableViewRowAnimation.automatic)
            }

            self.chatTableViewData.reverse()

            for index in 0...self.chatTableViewData.count-1 {
                print(self.log, "asdasd")
                self.index = index+1
                self.tableView.insertRows(at: [IndexPath(row: self.index-1, section: 0)],  with: UITableViewRowAnimation.automatic)
                //print(self.log, self.tableView.numberOfRows(inSection: 0))
            }
            
        }){(error) in
            print(error.localizedDescription)
        }
    }
    
    func dateToStringFormat(date: Date) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatterGet.string(from: date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class ChatTableViewParentCell: UITableViewCell{
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var labelComments: UILabel!
    
}
