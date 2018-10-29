//
//  PreparingToLaunch.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 18..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import Foundation

class PreparingToLaunch{
    
    private var targetVC: UIViewController?
    
    init(vc:UIViewController) {
        self.targetVC = vc
    }
    
    func show(){
        
        let alertController = UIAlertController(title: "서비스 준비중..",message: "개발자가 열심히 개발중입니다!", preferredStyle: .actionSheet)
        
        //UIAlertActionStye.destructive 지정 글꼴 색상 변경
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
        }
        
        alertController.addAction(okAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = targetVC?.view
            popoverController.sourceRect = CGRect(x: (targetVC?.view.bounds.midX)!, y: (targetVC?.view.bounds.midY)!, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        targetVC?.present(alertController,animated: true){
            alertController.view.superview?.subviews.first?.isUserInteractionEnabled = true
            
            // Adding Tap Gesture to Overlay
            alertController.view.superview?.subviews.first?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actionSheetBackgroundTapped)))
        }
        
    }
    
    @objc func actionSheetBackgroundTapped(){
        print("tagg eedfed?")
        targetVC?.dismiss(animated: true, completion: nil)
    }
    
}
