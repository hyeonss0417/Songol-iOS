//
//  CheckAuthViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 18/07/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import WebKit

protocol CheckAuthCoordinatorDelegate {
    func coordinateMain()
    func coordinateLogin()
}

class CheckAuthViewController: BaseUIViewController {
    var coordinator: CheckAuthCoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user.username == "guest" {
            //게스트 계정 로그인 시 3초 대기
            Timers.set(duration: 3){
                    self.coordinator?.coordinateMain()
            }
        }
        
        CookieManager.clearCookies()
        KauLoginView().tryLogin(id: user.username, pw: user.pw, parent: self, showDialog: false) { type, res in
            switch(res) {
            case .success:
                self.coordinator?.coordinateMain()
            case .failure:
                LoginFailAlert.shared.show(on: self)
            }
        }
    }
}
