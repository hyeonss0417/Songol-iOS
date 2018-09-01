//
//  ViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 8. 30..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var navMenuButton: UIBarButtonItem!
    
    let imgs_menu = [#imageLiteral(resourceName: "main_board"), #imageLiteral(resourceName: "main_board_major"), #imageLiteral(resourceName: "main_library_seat"), #imageLiteral(resourceName: "main_calendar"), #imageLiteral(resourceName: "main_dish"), #imageLiteral(resourceName: "main_delivery"), #imageLiteral(resourceName: "main_time_table"), #imageLiteral(resourceName: "main_chat"), #imageLiteral(resourceName: "main_professor")]
    let icons_menu = [#imageLiteral(resourceName: "main_board_icon"), #imageLiteral(resourceName: "main_board_major_icon"), #imageLiteral(resourceName: "main_library_seat_icon"), #imageLiteral(resourceName: "main_calendar_icon"), #imageLiteral(resourceName: "main_dish_icon"), #imageLiteral(resourceName: "main_delivery_icon"), #imageLiteral(resourceName: "main_time_table_icon"), #imageLiteral(resourceName: "main_chat_icon"), #imageLiteral(resourceName: "main_professor_icon")]
    let str_menu = ["게시판","과별 게시판", "열람실 좌석현황", "학사 일정", "식단표", "배달음식", "시간표", "오픈 채팅","교수님 정보"]
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        //image counting
        return imgs_menu.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        // put image
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! CustomCell
        
        cell.menuImage.image = imgs_menu[indexPath.row]
        cell.iconImage.image = icons_menu[indexPath.row]
        cell.label.text = str_menu[indexPath.row]
        cell.label.textColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
            
        case 2:
            performSegue(withIdentifier: "seat", sender: nil)
        case 3:
            performSegue(withIdentifier: "calendar", sender: nil)
            break;
        case 4:
            performSegue(withIdentifier: "dish", sender: nil)
            break;
        default:
            break;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width/3 - 1
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //  행 하단 여백
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 컬럼 여백
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navMenuButton.target = self.revealViewController()
        navMenuButton.action = Selector("revealToggle:")
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class CustomCell:UICollectionViewCell{
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    
}

