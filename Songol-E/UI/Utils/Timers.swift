//
//  Timers.swift
//  Songol-E
//
//  Created by 최민섭 on 29/07/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

struct Timers{
    
    func set(duration: Int, completion: @escaping () -> Void){
        let time = DispatchTime.now() + .seconds(duration)
        DispatchQueue.main.asyncAfter(deadline: time) {
            completion()
        }
    }
}
