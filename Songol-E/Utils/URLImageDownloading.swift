//
//  URLImageDownloading.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 3..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class URLImageDownloading {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    public func downloadImage(from url: URL, imageView:UIImageView) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
            }
        }
    }
}
