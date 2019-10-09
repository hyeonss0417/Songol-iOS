//
//  DeliveryViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 1..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DeliveryPagerViewController: ButtonBarPagerTabStripViewController {

 let blueInspireColor = UIColor(red: 34/255.0, green: 45/255.0, blue: 103/255.0, alpha: 1.0)
 let oldCellColor = UIColor(displayP3Red: 0.07, green: 0.27, blue: 0.53, alpha: 0.4)
    
    override func viewDidLoad() {
        // change selected bar color
        
        self.title = "배달음식"
        
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = blueInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 17)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = self?.oldCellColor
            newCell?.label.textColor = self?.blueInspireColor
        }
        super.viewDidLoad()
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    
        let child_1 = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "deliveryChild") as! DeliveryMenuListViewController
        child_1.setCategory(category: "치킨")
        
        let child_2 = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "deliveryChild") as! DeliveryMenuListViewController
        child_2.setCategory(category: "피자")
        
        let child_3 = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "deliveryChild") as! DeliveryMenuListViewController
        child_3.setCategory(category: "중식")
        
        let child_4 = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "deliveryChild") as! DeliveryMenuListViewController
        child_4.setCategory(category: "떡볶이")
        
        let child_5 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "deliveryChild") as! DeliveryMenuListViewController
        child_5.setCategory(category: "기타")
        
        return [child_1, child_2, child_3, child_4, child_5]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
