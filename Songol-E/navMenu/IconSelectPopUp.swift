//
//  IconSelectPopUp.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 16..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class IconSelectPopUp : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    private var willChangeIcon:UIImage?
    private var navVC : NavRealViewController?
    private var curSelectedIndex: IndexPath?
    
    
    func setNavVCInstance(navVC : NavRealViewController){
        self.navVC = navVC
    }

    
    @IBAction func IconChangeOnClicked(_ sender: Any) {
        
        if  willChangeIcon != nil{
            
            let accountInfo = AccountInfo()
            
            var userinfo = accountInfo.getUserInfo()
            
            let snum:String = accountInfo.getSnumberFromImageSrc(img: willChangeIcon!)
            
            navVC?.changeView(imgSource: (willChangeIcon)!, label: accountInfo.usernameSelection(snum: snum))
            
            //have to firebase DB change
            
            userinfo = UserInfo(major: (userinfo.major)!, pw: userinfo.pw, snumber: snum, username: userinfo.username)
            accountInfo.storeUserInfo(userInfo: userinfo)
            
            dismiss(animated: false, completion: nil)
        }
    }
    
    let icons = [#imageLiteral(resourceName: "chick0_"), #imageLiteral(resourceName: "chick1_"), #imageLiteral(resourceName: "chick2_"), #imageLiteral(resourceName: "chick3_"), #imageLiteral(resourceName: "chick4_"), #imageLiteral(resourceName: "chick5_"), #imageLiteral(resourceName: "chick6_")]
    
    @IBAction func BgrTouchOnClicked(_ sender: Any) {
        
        dismiss(animated: false, completion: nil)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }

    @IBOutlet weak var mCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconPopupCell", for: indexPath) as! IconPopupCell
        
        cell.imgIcon.image = icons[indexPath.row]
        cell.imgIcon.frame.size = CGSize( width: view.frame.width, height: view.frame.width )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        willChangeIcon = icons[indexPath.row]
        
        if curSelectedIndex != nil{
            let preCell = collectionView.cellForItem(at: curSelectedIndex!)
            preCell?.layer.borderWidth = 0
            preCell?.layer.borderColor = .none
        }
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.gray.cgColor
        
        curSelectedIndex = indexPath
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mCollectionView.collectionViewLayout = CustomImageFlowLayout.init()
    }
}

class IconPopupCell:UICollectionViewCell{
    @IBOutlet weak var imgIcon: UIImageView!
}
