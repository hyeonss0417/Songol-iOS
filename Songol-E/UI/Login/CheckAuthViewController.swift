//
//  CheckAuthViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 18/07/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import WebKit

class CheckAuthViewController: BaseUIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user?.username == "guest" {
            //게스트 계정 로그인 시 3초 대기
            Timers.set(duration: 3){
                CommonUtils().replaceRootViewController(identifier: .main)
            }
        }
        
        CommonUtils().clearCookies()
        
        LoginHelper().tryLogin(id: user!.username!, pw: user!.pw!, parent: self, showDialog: false) { type, res in            
            switch(res) {
            case .success:
                CommonUtils().replaceRootViewController(identifier: .main)
            case .failure:
                LoginFailAlert.shared.show(on: self)
            }
        }
    }
}
