//
//  SelectMajorViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 7..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class SelectMajorViewController: UIViewController {
    
    var preSelectedBtn: UIButton?
    
    @IBAction func changeMajor(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
        preSelectedBtn?.backgroundColor = UIColor.clear
        preSelectedBtn = button
        
        if  button.tag == 10{
            //start main viewController with User Data
        }
        
        button.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        print(button.currentTitle!)
        
//        switch button.tag {
//        case 1:
//            print("경영")
//            break
//        case 2:
//            print("교물")
//            break
//        case 3:
//            print("소프트")
//            break
//        case 4:
//            print("재료")
//            break
//        case 5:
//            print("운항")
//            break
//        case 6:
//            print("운항")
//            break
//        case 7:
//            print("운항")
//            break
//        case 8:
//            print("운항")
//            break
//        case 9:
//            print("운항")
//            break
//        case 10:
//            print("운항")
//            break
//        default:
//            print("Unknown language")
//            return
//        }
    }
    
    override func viewDidLoad() {
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
