//
//  BaseViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 19..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

enum UserError: Error {
    case nilUserError
}

class BaseUIViewController: UIViewController {
    
    func callback(){}
    func setNavData(){}

    var user: UserInfo = {
        guard let user = CommonUtils.sharedInstance.user else {
            CommonUtils.sharedInstance.replaceRootViewController(identifier: .login)
            return UserInfo(uid: String(),
                            major: String(),
                            pw: String(),
                            snumber: String(),
                            username: String())
        }
        
        return user
    }()
    
    let loadingDialog = LoadingDialog()
    
}
