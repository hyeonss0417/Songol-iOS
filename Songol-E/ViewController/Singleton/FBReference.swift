//
//  FBReference.swift
//  Songol-E
//
//  Created by 최민섭 on 11/09/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Firebase
import FirebaseDatabase

struct FBReference {
    static let shared = FBReference()
    let db = Database.database().reference()
}