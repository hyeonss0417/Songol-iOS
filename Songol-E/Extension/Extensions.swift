//
//  Extensions.swift
//  Songol-E
//
//  Created by 최민섭 on 11/09/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

extension TimeInterval {
    func formattedStringFromNow(now: NSDate) -> String {
        let date = NSDate(timeIntervalSince1970: self/1000)
        let dateFormatterGet = DateFormatter()
        let timeIntervalFromNow = Int(now.timeIntervalSince(date as Date) / 3600) //86400

        switch timeIntervalFromNow {
        case 0..<1:
            let minuteIntervalFromNow = Int(now.timeIntervalSince(date as Date) / 60)
            if minuteIntervalFromNow < 1 {
                let secondIntervalFromNow = Int(now.timeIntervalSince(date as Date))
                return "\(secondIntervalFromNow)초전"
            }
            return "\(minuteIntervalFromNow)분전"
        case 1..<24:
            return "\(timeIntervalFromNow)시간전"
        case 24:
            return "어제"
        case 25..<8640:
            dateFormatterGet.dateFormat = "M월 d일"

            let calendar = Calendar.current
            let year = calendar.component(.year, from: date as Date)
            let currentYear = calendar.component(.year, from: now as Date)
            if currentYear > year {
                dateFormatterGet.dateFormat = "yy.MM.dd"
            }
            
            return dateFormatterGet.string(from: date as Date)
        default:
            dateFormatterGet.dateFormat = "yy.MM.dd"
            return dateFormatterGet.string(from: date as Date)
        }
    }
}

extension UIView {
    func addAutoLayout(parent: UIView, topConstraint: UIView? = nil, bottomConstraint: UIView? = nil, heightRatio: CGFloat = 1, widthRatio: CGFloat = 1) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
        
        if let topConstraint = topConstraint {
            self.topAnchor.constraint(equalTo: topConstraint.bottomAnchor).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        }
        
        if let bottomConstraint = bottomConstraint {
            self.bottomAnchor.constraint(equalTo: bottomConstraint.topAnchor).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        }
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    private static var _url = [String:String]()
    
    var url: String {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIImageView._url[tmpAddress] ?? ""
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIImageView._url[tmpAddress] = newValue
        }
    }
    
    func loadImageAsyc(fromURL stringUrl : String, fromPomangamAPI: Bool = true) {
        guard let url = URL(string: stringUrl) else { return }
        
        self.url = stringUrl
        
        if let imageFromCache = imageCache.object(forKey: stringUrl as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data:Data?, res:URLResponse?, error:Error?) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            DispatchQueue.global().async {
                guard let data = data, let imageToCache = UIImage(data: data) else {
                    print("Image Data Error")
                    return
                }
                
                if self.url == stringUrl {
                    DispatchQueue.main.async {
                        UIView.transition(with: self,
                                          duration:0.5,
                                          options: .transitionCrossDissolve,
                                          animations: { self.image = imageToCache },
                                          completion: nil)
                        imageCache.setObject(imageToCache, forKey: stringUrl as AnyObject)
                    }
                }
            }
        }.resume()
    }
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

enum StoryBoards: String {
    case main = "Main"
    case delivery = "Delivery"
}

protocol Initializable {
    static func initalize(storyboard: StoryBoards) -> Self?
}

extension UIViewController: Initializable {
    static func initalize(storyboard: StoryBoards) -> Self? {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        
        return storyboard.getInitialVC(type: self)
    }
}

extension UIStoryboard {
    func getInitialVC<T: UIViewController>(type: T.Type) -> T? {
        return instantiateInitialViewController() as? T
    }
}
