//
//  IconSelectPopUp.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 16..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class IconSelectPopUp : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    private var dbRef : DatabaseReference! // 인스턴스 변수
    private var willChangeIcon:UIImage?
    private var navVC : NavRealViewController?
    private var majorVC : SelectMajorViewController?
    private var curSelectedIndex: IndexPath?
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var labelChange: UILabel!
    private var labelStr:String?
    private var btnStr:String?
    
    
    func setNavVCInstance(navVC : NavRealViewController){
        self.navVC = navVC
        labelStr = "아이콘 변경하기"
        btnStr = "변경하기"
    }
    
    func setMajorVCInstance(majorVC: SelectMajorViewController){
        self.majorVC = majorVC
        labelStr = "아이콘 선택하기"
        btnStr = "너로 정했다!"
    }
    
    @IBAction func IconChangeOnClicked(_ sender: Any) {
        
        if  willChangeIcon != nil && navVC != nil{
            
            //case 1 : navVC
            
            let accountInfo = AccountInfo()
            
            var userinfo = accountInfo.getUserInfo()
            
            let snum:String = accountInfo.getSnumberFromImageSrc(img: willChangeIcon!)
            
            navVC?.changeView(imgSource: (willChangeIcon)!, label: accountInfo.usernameSelection(snum: snum), snum: snum)
           
            
            //change FirebaseDB snumber
            changeUserSnum(uid: userinfo.uid!, snum: snum)
            
            userinfo = UserInfo(uid: userinfo.uid!, major: (userinfo.major)!, pw: userinfo.pw, snumber: snum, username: userinfo.username)
            
            accountInfo.storeUserInfo(userInfo: userinfo)
            
            dismiss(animated: false, completion: nil)
            
        }else if  willChangeIcon != nil && majorVC != nil{
            
            //case 2 : SelectMajor VC
            
            let snum:String = AccountInfo().getSnumberFromImageSrc(img: willChangeIcon!)
            majorVC?.setSnumber(snum: snum)
            
        }
    }
    
    func changeUserSnum(uid:String, snum:String){
        self.dbRef.child("Users/\(uid)/snumber").setValue(snum)
    }
    
    let icons = [#imageLiteral(resourceName: "chick1_"), #imageLiteral(resourceName: "chick2_"), #imageLiteral(resourceName: "chick3_"), #imageLiteral(resourceName: "chick4_"), #imageLiteral(resourceName: "chick5_"), #imageLiteral(resourceName: "chick6_")]
    
    @IBAction func BgrTouchOnClicked(_ sender: Any) {
        
        if navVC != nil{
            dismiss(animated: false, completion: nil)
        }

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
        
        dbRef = Database.database().reference()
        
        self.mCollectionView.collectionViewLayout = CustomImageFlowLayout.init()
        
        labelChange.text = labelStr
        btnChange.titleLabel?.text = btnStr
        
    }
}

class IconPopupCell:UICollectionViewCell{
    @IBOutlet weak var imgIcon: UIImageView!
}