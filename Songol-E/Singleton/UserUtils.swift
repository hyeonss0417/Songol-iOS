//
//  UserUtils.swift
//  Songol-E
//
//  Created by 최민섭 on 18/07/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

struct UserUtil{
    static func getType(id: String, completion: (UserType) -> Void) {
        if id == "guest" {
            completion(.guest)
        } else {
            completion(.normal)
        }
    }
}
