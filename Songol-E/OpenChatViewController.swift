//
//  OpenChatViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 11..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

struct parentCellData{
    var opened = Bool()
    var iconImage = UIImage()
    var username = String()
    var date = String()
    var text = String()
    var sectionData = [childCellData]()
}

struct childCellData{
    var iconImage = UIImage()
    var username = String()
    var date = String()
    var text = String()
}

class OpenChatViewController: UITableViewController {

    var chatTableViewData : [parentCellData] = []
    var dbRef : DatabaseReference! // 인스턴스 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "오픈 채팅"
        
        dbRef = Database.database().reference()
        
        self.tableView.separatorColor = .clear
        
        readChatList()
        
//        chatTableViewData = [parentCellData(opened: false, imageUrl: "", username: "Parent1", date: "", text: "im your dad", sectionData: [childCellData(imageUrl: "", username: "Child1", date: "", text: "im child1"), childCellData(imageUrl: "", username: "Child2", date: "", text: "im child2"), childCellData(imageUrl: "", username: "Child3", date: "", text: "im child3")]),
//            parentCellData(opened: false, imageUrl: "", username: "Parent2", date: "", text: "im your dad", sectionData: [childCellData(imageUrl: "", username: "Child1", date: "", text: "im child1"), childCellData(imageUrl: "", username: "Child2", date: "", text: "im child2"), childCellData(imageUrl: "", username: "Child3", date: "", text: "im child3")]),
//            parentCellData(opened: false, imageUrl: "", username: "Parent3", date: "", text: "im your dad", sectionData: [childCellData(imageUrl: "", username: "Child1", date: "", text: "im child1"), childCellData(imageUrl: "", username: "Child2", date: "", text: "im child2"), childCellData(imageUrl: "", username: "Child3", date: "", text: "im child3")])]
        
    }
    
    func readChatList(){
        
        dbRef.child("Questions").observe(.childAdded, with: {(snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let iconImage = IconSelection().iconSelection(snum: value?["snum"] as! String)
            
            let username = UserNameSelection().usernameSelection(snum: value?["snum"] as! String)
            
            let date = self.dateToStringFormat(date:
                Date(timeIntervalSince1970: value?["date"] as! TimeInterval))
            
            var childCount = value?["numofcom"] as! Int
            
            var childData = [childCellData]()
            
            
            self.dbRef.child("Child").child(String(Int(value?["date"] as! TimeInterval))).observe(.childAdded, with: {(childSnapshot) in

                childCount = childCount - 1
                
                print(childCount)

                let childValue = childSnapshot.value as? NSDictionary

                let childIconImage = IconSelection().iconSelection(snum: childValue?["snum"] as! String)

                let childUsername = UserNameSelection().usernameSelection(snum: childValue?["snum"] as! String)

                let childDate = self.dateToStringFormat(date:
                    Date(timeIntervalSince1970: childValue?["date"] as! TimeInterval))

                let childText = childValue?["text"] as! String

                childData.append(childCellData(iconImage: childIconImage, username: childUsername, date: childDate, text: childText))

                if childCount <= 0{
                    print("im in!")
                    
                    self.chatTableViewData.append(
                    parentCellData(opened: false, iconImage: iconImage, username: username, date: date, text: value?["text"] as! String, sectionData: childData) )
                    
                    print(self.chatTableViewData.count)
                    
                    self.tableView.insertRows(at: [IndexPath(row: self.chatTableViewData.count - 1, section: 0)],  with: UITableViewRowAnimation.automatic)
                }

            }){(error) in
                print(error.localizedDescription)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return chatTableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if chatTableViewData[section].opened == true {
            return chatTableViewData[section].sectionData.count + 1
        }else{
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1

        if  indexPath.row == 0 { // parent
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatTableViewCell
            tableViewParentChangeListener(cell: cell, indexPath: indexPath, cellData: chatTableViewData[indexPath.section])
            return cell
            
        }else{ // child
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "chatChildCell", for: indexPath) as! ChatTableViewChildCell
            tableViewChildChangeListener(cell: cell, indexPath: indexPath, cellData: chatTableViewData[indexPath.section].sectionData[dataIndex])
            return cell

        }
    }
    
    func tableViewParentChangeListener(cell: ChatTableViewCell, indexPath: IndexPath, cellData: parentCellData){
        
        cell.imageChar.image = #imageLiteral(resourceName: "chick3")
        
        cell.labelUserName.text = cellData.username
        
        cell.labelDate.text = String(indexPath.row)
        cell.labelText.text = "im your parent!!" + String(indexPath.row)
        
        cell.labelCommentsNum.text = String(cellData.sectionData.count)+"개의 댓글"
        
        if cellData.opened == true{
            cell.imageOpenComments.image = #imageLiteral(resourceName: "circle_minus")
        }else{
            cell.imageOpenComments.image =  #imageLiteral(resourceName: "circle_plus")
        }
    }
    
    func tableViewChildChangeListener(cell: ChatTableViewChildCell, indexPath: IndexPath, cellData: childCellData){
     
        cell.imageChar.image = #imageLiteral(resourceName: "chick1")
        
        cell.labelUserName.text = cellData.username
        
        cell.labelDate.text = String(indexPath.row)
        
        cell.labelText.text = "im child !!!"
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {// cell click event
        if indexPath.row == 0{
            
            if chatTableViewData[indexPath.section].opened == true{
                
                chatTableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
                
            }else{
                chatTableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
}

class ChatTableViewCell: UITableViewCell{
    
    @IBOutlet weak var imageChar: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var buttonComments: UIButton!
    @IBOutlet weak var labelCommentsNum: UILabel!
    @IBOutlet weak var imageOpenComments: UIImageView!
}

class ChatTableViewChildCell: UITableViewCell{
    @IBOutlet weak var imageChar: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelText: UILabel!
    
}
