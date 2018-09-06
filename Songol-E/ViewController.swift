//
//  ViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 8. 30..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let blueInspireColor = UIColor(red: 34/255.0, green: 45/255.0, blue: 103/255.0, alpha: 1.0)
    
    @IBOutlet weak var navMenuButton: UIBarButtonItem!

    
    let imgs_menu = [#imageLiteral(resourceName: "main_board_"), #imageLiteral(resourceName: "main_board_major_"), #imageLiteral(resourceName: "main_library_seat_"), #imageLiteral(resourceName: "main_calendar_"), #imageLiteral(resourceName: "main_dish_"), #imageLiteral(resourceName: "main_delivery_"), #imageLiteral(resourceName: "main_time_table_"), #imageLiteral(resourceName: "main_chat_"), #imageLiteral(resourceName: "main_professor_")]
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
        case 5:
            performSegue(withIdentifier: "delivery", sender: nil)
            break;
        case 8:
            performSegue(withIdentifier: "professorInfo", sender: nil)
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
    
        viewInit()
    }
    
    func viewInit(){
        self.navigationItem.leftBarButtonItem?.tintColor = blueInspireColor
        
        //it doesnt work.....
        self.navigationItem.backBarButtonItem?.tintColor = blueInspireColor
        
        //remove border
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //remove back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        navMenuButton.target = self.revealViewController()
        navMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
   
        //set RevealView Event
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        bgrClickEvent()
    }
    
    @IBOutlet weak var imageBgr: UIImageView!
    func bgrClickEvent(){
        imageBgr.isUserInteractionEnabled = true
        imageBgr.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("buttonTapped")))
    }
    
    @objc func buttonTapped(){
        performSegue(withIdentifier: "login", sender: nil)
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

