//
//  OpenChatViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 11..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

struct parentCellData{
    var opened = Bool()
    var imageUrl = String()
    var username = String()
    var date = String()
    var text = String()
    var sectionData = [childCellData]()
}

struct childCellData{
    var imageUrl = String()
    var username = String()
    var date = String()
    var text = String()
}

class OpenChatViewController: UITableViewController {

    var chatTableViewData = [parentCellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "오픈 채팅"
        
        
        chatTableViewData = [parentCellData(opened: false, imageUrl: "", username: "Parent1", date: "", text: "im your dad", sectionData: [childCellData(imageUrl: "", username: "Child1", date: "", text: "im child1"), childCellData(imageUrl: "", username: "Child2", date: "", text: "im child2"), childCellData(imageUrl: "", username: "Child3", date: "", text: "im child3")]),
            parentCellData(opened: false, imageUrl: "", username: "Parent2", date: "", text: "im your dad", sectionData: [childCellData(imageUrl: "", username: "Child1", date: "", text: "im child1"), childCellData(imageUrl: "", username: "Child2", date: "", text: "im child2"), childCellData(imageUrl: "", username: "Child3", date: "", text: "im child3")]),
            parentCellData(opened: false, imageUrl: "", username: "Parent3", date: "", text: "im your dad", sectionData: [childCellData(imageUrl: "", username: "Child1", date: "", text: "im child1"), childCellData(imageUrl: "", username: "Child2", date: "", text: "im child2"), childCellData(imageUrl: "", username: "Child3", date: "", text: "im child3")])]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
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
        
        cell.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 0.7)
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
