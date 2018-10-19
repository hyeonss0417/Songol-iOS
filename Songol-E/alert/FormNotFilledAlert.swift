//
//  FormNotFilledAlert.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 19..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import Foundation

struct FormNotFilledAlert{
    
    private var vc:UIViewController?
    
    init(vc:UIViewController) {
        self.vc = vc
    }
    
    func show(){
        
        let alertController = UIAlertController(title: "로그인 실패",message: "ID/PW 를 모두 입력하십시오.", preferredStyle: UIAlertControllerStyle.alert)
        
        //UIAlertActionStye.destructive 지정 글꼴 색상 변경
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
        }
        
        alertController.addAction(okAction)
        
        vc?.present(alertController,animated: true,completion: nil)
        
    }
    
}
