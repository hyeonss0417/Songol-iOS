////
////  ChildViewNav.swift
////  Songol-E
////
////  Created by 최민섭 on 17/11/2018.
////  Copyright © 2018 최민섭. All rights reserved.
////
//
//import UIKit
//
//class ChildViewNav: UIStoryboardSegue{
//    override func perform() {
//        let viewController:PortalCheckViewController = self.source as! PortalCheckViewController
//        let destinationController : UIViewController = self.destination
//        //이전 뷰 날리는 코드
//        for view in (viewController.mFrameView!.subviews) {
////            view.removeFromSuperview()
//        }
//
//        let childView: UIView = destination.view
//        viewController.currentViewController = destinationController
//        viewController.mFrameView.addSubview(childView)
//
//        childView.translatesAutoresizingMaskIntoConstraints = false
//        childView.topAnchor.constraint(equalTo: viewController.mFrameView.topAnchor).isActive = true
//        childView.leftAnchor.constraint(equalTo: viewController.mFrameView.leftAnchor).isActive = true
//        childView.rightAnchor.constraint(equalTo: viewController.mFrameView.rightAnchor).isActive = true
//        childView.bottomAnchor.constraint(equalTo: viewController.mFrameView.bottomAnchor).isActive = true
//        viewController.mFrameView.layoutIfNeeded()
//    }
//}
