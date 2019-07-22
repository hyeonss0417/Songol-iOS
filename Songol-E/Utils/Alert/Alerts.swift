//
//  LoginFailAlert.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 17..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import Foundation

struct Alerts{
    
    enum Types {
        case loginFail
        case loginDenied
        case prepareForLaunching
    }
    
    
    
    private var targetVC: UIViewController?
    
    init(vc:UIViewController, type: Types) {
        self.targetVC = vc
        
    }
    
    private func setAlertController(){
        
        
        
    }
    
    func show(){
        
        let alertController = UIAlertController(title: "로그인에 실패하였습니다.",message: "ID/PW 확인 후 재로그인 하십시오.", preferredStyle: UIAlertControllerStyle.alert)
        
        //UIAlertActionStye.destructive 지정 글꼴 색상 변경
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
        }
        
        alertController.addAction(okAction)
        
        targetVC?.present(alertController,animated: true,completion: nil)
        
    }
    
}
