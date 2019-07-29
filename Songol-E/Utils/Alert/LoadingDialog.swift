//
//  LoadingDialog.swift
//  Songol-E
//
//  Created by 최민섭 on 03/11/2018.
//  Copyright © 2018 최민섭. All rights reserved.
//

class LoadingDialog: PageLoadingProtocol {
    
    var spinner: UIView?
    
    func displaySpinner(on onView : UIView) {
        
        let spinner = UIView.init(frame: onView.bounds)
        spinner.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinner.center
        
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
