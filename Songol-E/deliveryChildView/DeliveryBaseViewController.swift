//
//  DeliveryBaseViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 2..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import XLPagerTabStrip


class DeliveryBaseViewController: UIViewController, IndicatorInfoProvider, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var category: String?
    
    var _tableView:UITableView?
    
    var deliveryInfoToSend: DeliveryFoodModel?
    
    var deliveryFoodArrays:[DeliveryFoodModel] = []
    var dbRef : DatabaseReference! // 인스턴스 변수
    
    func setCategory(category:String){
        self.category = category
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryFoodArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryTableCell", for: indexPath) as! DeliveryTableViewCell
        
        tableViewChangeListener(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        deliveryInfoToSend =  deliveryFoodArrays[indexPath.row]
        performSegue(withIdentifier: "deliveryDetail", sender: nil)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "deliveryDetail" {
            if let destinationVC = segue.destination as? DeliveryChildDetailViewController {
                destinationVC.setDeliveryInfo(deliveryInfo: deliveryInfoToSend!)
            }
        }
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: category!)
    }

    func initTableView(_tableView:UITableView){
        self._tableView = _tableView
        _tableView.rowHeight = 80
    }
    
    func tableViewChangeListener(cell:DeliveryTableViewCell, indexPath: IndexPath){
        cell.labelTitle.text = deliveryFoodArrays[indexPath.row].foodName
        cell.labelNumber.text = deliveryFoodArrays[indexPath.row].number
        
        cell.imageLogo.layer.borderWidth = 1
        cell.imageLogo.layer.masksToBounds = false
        cell.imageLogo.layer.borderColor = UIColor.white.cgColor
        cell.imageLogo.layer.cornerRadius = cell.imageLogo.frame.height/2
        cell.imageLogo.clipsToBounds = true
        
        URLImageDownloading().downloadImage(from: URL(string: deliveryFoodArrays[indexPath.row].imgLogo_url)!,imageView: cell.imageLogo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView(_tableView: tableView)
        
        dbRef = Database.database().reference()

        readDeliveryList(category: category!)
    }
    
    func readDeliveryList(category:String){

        dbRef.child("Delivery").child(category).observeSingleEvent(of: .value, with: { (snapshot) in
            
            for child in snapshot.children{
                let value = (child as! DataSnapshot).value as? NSDictionary
                
                let deliveryFoodModel = DeliveryFoodModel(foodName: value?["foodName"] as? String ?? "", avg_speedScore: value?["avg_speedScore"] as? String ?? "",avg_tasteScore: value?["avg_tasteScore"] as? String ?? "",imgLogo_url: value?["imgLogo_url"] as? String ?? "",imgMenu_url: value?["imgMenu_url"] as? String ?? "",number: value?["number"] as? String ?? "",s_time: value?["s_time"] as? String ?? "")
                self.deliveryFoodArrays.append(deliveryFoodModel)
                
                self._tableView?.insertRows(at: [IndexPath(row: self.deliveryFoodArrays.count - 1, section: 0)], with: UITableViewRowAnimation.automatic)
            }
            
        }){ (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
