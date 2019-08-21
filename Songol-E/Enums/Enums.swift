//
//  Enums.swift
//  Songol-E
//
//  Created by 최민섭 on 18/07/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation
import UIKit

enum UserType: String {
    case guest
    case normal
    case songol
}

enum ViewControllerNameType: String{
    case accessToWeb = "AccessWebViewController"
    case developerIntroducing = "DeveloperViewController"
    case login = "LoginViewController"
    case main = "SWRevealViewController"
}
