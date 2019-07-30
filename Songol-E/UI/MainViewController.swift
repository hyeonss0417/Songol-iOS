//
//  ViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 8. 30..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class MainViewController: BaseUIViewController {
    
    let blueInspireColor = UIColor(red: 34/255.0, green: 45/255.0, blue: 103/255.0, alpha: 1.0)
    
    @IBOutlet weak var navMenuButton: UIBarButtonItem!
    
    var positionValue : String?
    var currentViewController : MainViewController?
   
    lazy var userinfo:UserInfo = CommonUtils.sharedInstance.user!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initRevealView()
    }
    
    func initView(){
                
        self.navigationItem.leftBarButtonItem?.tintColor = blueInspireColor
        
        //remove border
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //remove back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        navMenuButton.target = self.revealViewController()
        navMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
   
        //set RevealView Event
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
    func initRevealView(){
        if positionValue != nil{
            performSegue(withIdentifier: positionValue!, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       if segue.identifier == "portalCheck" {
            if let destinationVC = segue.destination as? PortalCheckViewController {
                destinationVC.setChildInfo(stringURL2: "https://portal.kau.ac.kr/sugang/LectStuSchFr.jsp", stringTitle: "강의 시간표")
            }
       }else if segue.identifier == "lms" {
            if let destVC = segue.destination as? LMSViewController {
                destVC.stringURL = sender as! String
            }
       }
       else{
            NavMenuController().webRedirect(segue: segue)
        }
    }
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        //image counting
        return main_menu_imgs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        // put image
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! CustomCell
        
        cell.menuImage.image = main_menu_imgs[indexPath.row]
        cell.iconImage.image = main_menu_icons[indexPath.row]
        cell.label.text = main_menu_strs[indexPath.row]
        
        if(UIDevice.current.userInterfaceIdiom == .pad){
            cell.label.font = cell.label.font.withSize(30)
        }
        
        cell.label.textColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            PreparingToLaunch(vc: self).show()
        case 1:
            PreparingToLaunch(vc: self).show()
        case 2:
            performSegue(withIdentifier: "seat", sender: nil)
        case 3:
            performSegue(withIdentifier: "calendar", sender: nil)
            break;
        case 4:
            // performSegue(withIdentifier: "dish", sender: nil)
            PreparingToLaunch(vc: self).show()
            break;
        case 5:
            performSegue(withIdentifier: "delivery", sender: nil)
            break;
        case 6:
            performSegue(withIdentifier: "lms", sender: "https://portal.kau.ac.kr/sugang/LectStuSchFr.jsp")
            break;
        case 7:
            performSegue(withIdentifier: "chat", sender: nil)
            break;
        case 8:
            performSegue(withIdentifier: "lms", sender: UrlMyLms)
            break;
        default:
            break;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //device 별 colummn 갯수
        let nColumns: CGFloat = (UIDevice.current.userInterfaceIdiom == .phone) ? 3 : 4
        let width = collectionView.frame.width/nColumns - 1
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
    
}

class CustomCell:UICollectionViewCell{
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var label: UILabel!
}



