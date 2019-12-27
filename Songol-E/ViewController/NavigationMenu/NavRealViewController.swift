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
    
    private var userinfo = CommonUtils.sharedInstance.user
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let arrayImage = [#imageLiteral(resourceName: "nav_developer"), #imageLiteral(resourceName: "nav_club"), #imageLiteral(resourceName: "nav_book"), #imageLiteral(resourceName: "nav_book"),#imageLiteral(resourceName: "nav_timetable"),#imageLiteral(resourceName: "nav_score"), #imageLiteral(resourceName: "nav_score"), #imageLiteral(resourceName: "nav_scholarship"),#imageLiteral(resourceName: "nav_professor"),#imageLiteral(resourceName: "nav_logout")]
    
    let navigationItems = [
        NavigationItemInfo(title: "만든이", target: .developerIntroducing, pageUrl: nil),
        NavigationItemInfo(title: "동아리", target: .accessToWeb, pageUrl: UrlClub),
        NavigationItemInfo(title: "도서관 도서 검색", target: .accessToWeb, pageUrl: UrlSearchBooks),
        NavigationItemInfo(title: "스터디룸 예약현황", target: .accessToWeb, pageUrl: UrlStudyRooms),
        NavigationItemInfo(title: "시험 시간표", target: .accessToWeb, pageUrl: UrlExamTable),
        NavigationItemInfo(title: "학기성적(석차) 조회", target: .accessToWeb, pageUrl: URLCurrentScore),
        NavigationItemInfo(title: "성적 확인", target: .accessToWeb, pageUrl: UrlScore),
        NavigationItemInfo(title: "장학금 수혜내역", target: .accessToWeb, pageUrl: UrlScholarship),
        NavigationItemInfo(title: "교직원 정보", target: .accessToWeb, pageUrl: UrlProfessors),
        NavigationItemInfo(title: "로그아웃", target: .login, pageUrl: nil)
    ]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return navigationItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NavTableCell",for: indexPath) as! NavTableCell
        cell.cellImage.image = arrayImage[indexPath.row]
        cell.label.text = navigationItems[indexPath.row].title
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNavigation = segue.destination as! UINavigationController
        let destinationViewController = destinationNavigation.topViewController as! MainViewController
        destinationViewController.navigationIdentifier = navigationItems[self.tableView.indexPathForSelectedRow!.row]
    }
    
}


class NavTableCell:UITableViewCell{
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var label: UILabel!
}


