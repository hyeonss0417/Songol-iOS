//
//  ImageZoomViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 3..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import ImageScrollView

class ImageZoomViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    var imageUrl:String?
    var image:UIImage?
    

    public func setImageUrl(url:String){
        imageUrl = url
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.loadImageAsyc(fromURL: imageUrl!)
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTappedAction(_:))))
        
        scrollView.maximumZoomScale = 4.0
        scrollView.delegate = self
    }
}

extension ImageZoomViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        imageView.backgroundColor = .black
    }
    
    @objc func imageTappedAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
