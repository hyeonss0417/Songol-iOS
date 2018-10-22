//
//  ImageZoomViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 3..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import ImageScrollView

class ImageZoomViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var imageUrl:URL?

    var image:UIImage?

    public func setImageUrl(url:String){
        imageUrl = URL(string: url)
    }

    override func viewDidLoad() {

        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        scrollView.delegate = self
        
        downloadImage(from: imageUrl!)
        
    }

    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
                self.imageView.image = self.image!
            }
        }
    }


    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
