//
//  NavRealViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 8. 31..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class NavRealViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgUserIcon: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    
    private var accountInfo = AccountInfo()
    
    private var userinfo:UserInfo?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let arrayStr = ["만든이",/*"항공대 관련 페이지", "Haru",*/ "동아리", /*"화전역 열차 시간표",*/ "도서관 도서 검색", "스터디룸 예약현황",/*"시험 시간표","성적 확인", "장학금 수혜내역",*/"로그아웃"]
    let arrayImage = [#imageLiteral(resourceName: "nav_developer"),/*#imageLiteral(resourceName: "nav_fb"),#imageLiteral(resourceName: "nav_haru"),*/ #imageLiteral(resourceName: "nav_club"),/*#imageLiteral(resourceName: "nav_train"),*/ #imageLiteral(resourceName: "nav_book"), #imageLiteral(resourceName: "nav_book"),/*#imageLiteral(resourceName: "nav_timetable"),#imageLiteral(resourceName: "nav_score"),#imageLiteral(resourceName: "nav_scholarship"),*/#imageLiteral(resourceName: "nav_logout")]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrayStr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NavTableCell",for: indexPath) as! NavTableCell
        
        cell.cellImage.image = arrayImage[indexPath.row]
        cell.label.text = arrayStr[indexPath.row]
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        tableView.rowHeight = 60
    }
    
    func initView(){
        
        userinfo = accountInfo.getUserInfo()
        
        if userinfo?.snumber == "1111"{
            labelUserName.text = "이미지를 클릭하여 아이콘을 설정하세요"
        }else{
            labelUserName.text = AccountInfo().usernameSelection(snum: (userinfo?.snumber)!)
        }
        
        
        imgUserIcon.image = AccountInfo().navUserIconSelection(snum: (userinfo?.snumber)!)
        imgUserIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NavRealViewController.imgTapped)))
        imgUserIcon.isUserInteractionEnabled = true
        
    }
    
    @objc func imgTapped() {
        if userinfo?.username != "guest"{
            performSegue(withIdentifier: "iconselector", sender: self)
        }
    }
    
    public func changeView(imgSource:UIImage, label:String)
    {
        //firebase userinfo change
        
        labelUserName.text = label
        imgUserIcon.image = imgSource
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "iconselector"{
             let dest = segue.destination as! IconSelectPopUp
            dest.setNavVCInstance(navVC: self)
            
        }else{
            let destinationNavigation = segue.destination as! UINavigationController
            
            let destinationViewController = destinationNavigation.topViewController as! ViewController
            
            destinationViewController.positionValue = arrayStr[self.tableView.indexPathForSelectedRow!.row]
        }
        
    }
    
}


class NavTableCell:UITableViewCell{
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var label: UILabel!
}


