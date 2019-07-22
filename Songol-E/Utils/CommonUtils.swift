//
//  CommonUtils.swift
//  Songol-E
//
//  Created by 최민섭 on 18/07/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import WebKit

final class CommonUtils: NSObject {

    static let sharedInstance = CommonUtils()
    static let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var isGuest = false
    var user: UserInfo?
    
    func setUser(user: UserInfo){
        self.user = user
    }
    
    func alertLoginFail(on vc:UIViewController){
        let alertController = UIAlertController(title: "로그인에 실패하였습니다.",message: "ID/PW 확인 후 재로그인 하십시오.", preferredStyle: UIAlertControllerStyle.alert)
        
        //UIAlertActionStye.destructive 지정 글꼴 색상 변경
        let yesAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
            UIApplication.shared.keyWindow?.rootViewController =
                CommonUtils.mainStoryboard
                    .instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        }
        let noAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        
        vc.present(alertController,animated: true,completion: nil)
    }
    
    func macroKauLogin(on wk: WKWebView, id: String, pw: String){
        let loadUsernameJS = "document.getElementsByName('p_id')[0].value = \'\(id)\';"
        
        let loadPasswordJS = "document.getElementsByName('p_pwd')[0].value = \'\(pw)\';"
        
        let onClickEventJS =  "var cells = document.getElementsByTagName('img');" + "for(var i=0; i < cells.length; i++){ var status = cells[i].getAttribute('alt');if(status=='로그인버튼'){ cells[i].click(); break;} }"
        
        wk.evaluateJavaScript(loadUsernameJS + loadPasswordJS + onClickEventJS, completionHandler: nil)
        
    }
}
