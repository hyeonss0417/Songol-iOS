//
//  LoginFailAlert.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 17..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import Foundation

class LoginFailAlert {
    
    static let shared: LoginFailAlert = LoginFailAlert()
    private var targetVC: UIViewController?
    private var failureCount = 0
    
    func show(on target: UIViewController){
        self.failureCount += 1
        let title = "로그인에 실패하였습니다."
        let message = failureCount <= 2 ? "ID/PW 확인 후 다시 로그인 해주세요." : "Kau 서버에서 거부하였습니다. 앱 종료 후 다시 시도해 주세요."
        
        let alertController = UIAlertController(title: title,message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //UIAlertActionStye.destructive 지정 글꼴 색상 변경
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
           CommonUtils().replaceRootViewController(identifier: .login)
        }
    
        alertController.addAction(okAction)
        targetVC?.present(alertController,animated: true,completion: nil)
    }
}
