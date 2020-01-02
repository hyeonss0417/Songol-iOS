//
//  LoadingDialog.swift
//  Songol-E
//
//  Created by 최민섭 on 03/11/2018.
//  Copyright © 2018 최민섭. All rights reserved.
//

class LoadingDialog {
    var spinner: UIView?
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    func displaySpinner(on onView : UIView) {
        let spinner = UIView.init(frame: onView.bounds)
        spinner.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        ai.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        ai.startAnimating()
        spinner.addSubview(self.stackView)
        onView.addSubview(spinner)
        
        self.spinner = spinner
        self.stackView.addArrangedSubview(ai)
        stackView.leftAnchor.constraint(equalTo: spinner.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: spinner.rightAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: spinner.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: spinner.centerYAnchor, constant: -50).isActive = true
    }
    
    func addSubview(view: UIView) {
        stackView.addArrangedSubview(view)
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.spinner?.removeFromSuperview()
        }
    }
    
}
