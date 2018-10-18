//
//  RequestSnum.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 18..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import Foundation

struct RequestSnum{
    
    private var targetVC: UIViewController?
    
    init(vc:UIViewController) {
        self.targetVC = vc
    }
    
    func show(){
        
//        let alertController = UIAlertController(title: "사용자 정보  ERROR", preferredStyle: UIAlertControllerStyle.alert)
        
        //UIAlertActionStye.destructive 지정 글꼴 색상 변경
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
        }
        
    }
    
}
