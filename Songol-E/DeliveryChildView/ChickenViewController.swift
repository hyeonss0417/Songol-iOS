//
//  DeliveryChildViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 1..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Firebase
import FirebaseDatabase

class ChickenViewController : UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChickenTableCell", for: indexPath) as! ChickenTableCell
        
        return cell
    }
    
    
    var dbRef : DatabaseReference! // 인스턴스 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = Database.database().reference()
        readDeliveryList()
    }
    
    func readDeliveryList(){
        
        dbRef.child("Delivery").child("치킨").observe(.childAdded, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let foodName = value?["foodName"] as? String ?? ""
            print("foodName : "+foodName)

        }){ (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "치킨")
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

class ChickenTableCell:UITableViewCell{
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    
}
