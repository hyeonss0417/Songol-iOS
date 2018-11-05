//
//  YesOrNoAlert.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 19..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import Foundation

struct YesOrNoAlert{
    
    //Yes 버튼 눌렀을때의 콜백 함수를 넘겨줄 수 있다면 좋을 것 같다 .. !
    //callback() 이라는 abstract 함수를 가진 ViewController를 상속받는 애들이면 되지 않을까?
    
    private var vc:BaseUIViewController?
    private var title:String?
    private var msg:String?
    
    init(vc:BaseUIViewController, title:String, msg: String) {
        self.vc = vc
        self.title = title
        self.msg = msg
    }
    
    func show(){
        
        
        if(UIDevice.current.userInterfaceIdiom == .phone){
            let alertController = UIAlertController(title: title,message: msg , preferredStyle: UIAlertControllerStyle.alert)
            
            //UIAlertActionStye.destructive 지정 글꼴 색상 변경
            //let noAction =
            
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
                self.vc?.callback()
            }
            let cancelActtion = UIAlertAction(title: "취소", style: UIAlertActionStyle.destructive)
            
            alertController.addAction(cancelActtion)
            alertController.addAction(okAction)
            
            vc?.present(alertController,animated: true,completion: nil)
        }
    }
    
    
    
}
