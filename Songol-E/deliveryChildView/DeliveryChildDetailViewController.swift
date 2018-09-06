//
//  DeliveryChildDetailViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 3..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class DeliveryChildDetailViewController: UIViewController {

    var deliveryInfo : DeliveryFoodModel?
    
    @IBOutlet weak var imageMenu: UIImageView!
    
    @IBOutlet weak var labelSTime: UILabel!
    
    @IBOutlet weak var labelAverage: UILabel!
    
    func setDeliveryInfo(deliveryInfo : DeliveryFoodModel){
        self.deliveryInfo = deliveryInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        URLImageDownloading().downloadImage(from: URL(string: (deliveryInfo?.imgMenu_url)!)!, imageView: imageMenu)

        imageMenu.isUserInteractionEnabled = true
        imageMenu.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("buttonTapped")))
    }
    
    @objc func buttonTapped() {
          performSegue(withIdentifier: "imageZoom", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageZoom" {
            if let destinationVC = segue.destination as? ImageZoomViewController {
                destinationVC.setImageUrl(url: (deliveryInfo?.imgMenu_url)!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
