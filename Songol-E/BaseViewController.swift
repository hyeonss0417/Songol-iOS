//
//  BaseViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 19..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {
    
    func callback(){}
    
    func setNavData(){}
    
    let user = CommonUtils.sharedInstance.user
    
    let loadingDialog = LoadingDialog()
    
}
