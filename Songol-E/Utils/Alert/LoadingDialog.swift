//
//  LoadingDialog.swift
//  Songol-E
//
//  Created by 최민섭 on 03/11/2018.
//  Copyright © 2018 최민섭. All rights reserved.
//

class LoadingDialog {
    
    var spinner: UIView?
    
    func displaySpinner(on onView : UIView) {
        let spinner = UIView.init(frame: onView.bounds)
        spinner.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        ai.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        ai.startAnimating()
        ai.center = CGPoint(x: spinner.bounds.width/2, y: spinner.bounds.height * 0.4)
        DispatchQueue.main.async {
            spinner.addSubview(ai)
            onView.addSubview(spinner)
            self.spinner = spinner
        }
    }
    
     func removeSpinner() {
        DispatchQueue.main.async {
            self.spinner?.removeFromSuperview()
        }
    }
    
}
